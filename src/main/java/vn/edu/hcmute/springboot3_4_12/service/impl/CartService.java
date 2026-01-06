package vn.edu.hcmute.springboot3_4_12.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.edu.hcmute.springboot3_4_12.dto.CartDTO;
import vn.edu.hcmute.springboot3_4_12.dto.CartItemDTO;
import vn.edu.hcmute.springboot3_4_12.dto.CartRequestDTO;
import vn.edu.hcmute.springboot3_4_12.entity.Cart;
import vn.edu.hcmute.springboot3_4_12.entity.CartItem;
import vn.edu.hcmute.springboot3_4_12.entity.Product;
import vn.edu.hcmute.springboot3_4_12.entity.User;
import vn.edu.hcmute.springboot3_4_12.repository.CartRepository;
import vn.edu.hcmute.springboot3_4_12.repository.CartItemRepository;
import vn.edu.hcmute.springboot3_4_12.repository.ProductRepository;
import vn.edu.hcmute.springboot3_4_12.repository.UserRepository;
import vn.edu.hcmute.springboot3_4_12.repository.VendorRepository;
import vn.edu.hcmute.springboot3_4_12.service.ICartService;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class CartService implements ICartService {

    private final CartRepository cartRepository;
    private final CartItemRepository cartItemRepository;
    private final ProductRepository productRepository;
    private final UserRepository userRepository;
    private final VendorRepository vendorRepository;

    @Override
    public CartDTO getCartByUserId(Long userId) {
        Cart cart = getOrCreateCart(userId);
        return convertToDTO(cart);
    }

    @Override
    public CartDTO addToCart(Long userId, CartRequestDTO request) {
        Cart cart = getOrCreateCart(userId);

        Product product = productRepository.findById(request.getProductId())
                .orElseThrow(() -> new RuntimeException("Product not found"));

        // Check if user is a vendor trying to add their own product
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        if ("VENDOR".equals(user.getRole())) {
            // Check if the product belongs to this vendor
            if (product.getVendor() != null) {
                Optional<vn.edu.hcmute.springboot3_4_12.entity.Vendor> vendorOpt = vendorRepository.findVendorByUser_Id(userId);
                if (vendorOpt.isPresent()) {
                    vn.edu.hcmute.springboot3_4_12.entity.Vendor vendor = vendorOpt.get();
                    if (product.getVendor().getId().equals(vendor.getId())) {
                        throw new RuntimeException("Bạn không thể thêm sản phẩm của chính mình vào giỏ hàng");
                    }
                }
            }
        }

        // Check if item already exists in cart
        Optional<CartItem> existingItem = cartItemRepository.findByCart_IdAndProduct_Id(cart.getId(), request.getProductId());

        if (existingItem.isPresent()) {
            // Update quantity
            CartItem item = existingItem.get();
            item.setQuantity(item.getQuantity() + request.getQuantity());
            cartItemRepository.save(item);
        } else {
            // Create new item
            CartItem item = new CartItem();
            item.setCart(cart);
            item.setProduct(product);
            item.setQuantity(request.getQuantity());
            cartItemRepository.save(item);
        }

        // Refresh cart and return
        cart = cartRepository.findById(cart.getId()).orElseThrow();
        updateCartTotal(cart);
        return convertToDTO(cart);
    }

    @Override
    public CartDTO updateCartItem(Long userId, Long itemId, Integer quantity) {
        Cart cart = getOrCreateCart(userId);

        CartItem item = cartItemRepository.findById(itemId)
                .orElseThrow(() -> new RuntimeException("Cart item not found"));

        if (!item.getCart().getId().equals(cart.getId())) {
            throw new RuntimeException("Item does not belong to user's cart");
        }

        if (quantity <= 0) {
            cartItemRepository.delete(item);
        } else {
            item.setQuantity(quantity);
            cartItemRepository.save(item);
        }

        updateCartTotal(cart);
        return convertToDTO(cart);
    }

    @Override
    public void removeCartItem(Long userId, Long itemId) {
        Cart cart = getOrCreateCart(userId);

        CartItem item = cartItemRepository.findById(itemId)
                .orElseThrow(() -> new RuntimeException("Cart item not found"));

        if (!item.getCart().getId().equals(cart.getId())) {
            throw new RuntimeException("Item does not belong to user's cart");
        }

        cartItemRepository.delete(item);
        updateCartTotal(cart);
    }

    @Override
    public void clearCart(Long userId) {
        Cart cart = getOrCreateCart(userId);
        cartItemRepository.deleteByCart_Id(cart.getId());
        cart.setTotalPrice(0.0);
        cartRepository.save(cart);
    }

    private Cart getOrCreateCart(Long userId) {
        Optional<Cart> cartOpt = cartRepository.findByUser_Id(userId);

        if (cartOpt.isPresent()) {
            return cartOpt.get();
        }

        // Create new cart
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Cart cart = new Cart();
        cart.setUser(user);
        cart.setTotalPrice(0.0);
        return cartRepository.save(cart);
    }

    private void updateCartTotal(Cart cart) {
        List<CartItem> items = cartItemRepository.findByCart_Id(cart.getId());
        double total = items.stream()
                .mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity())
                .sum();
        cart.setTotalPrice(total);
        cartRepository.save(cart);
    }

    private CartDTO convertToDTO(Cart cart) {
        List<CartItemDTO> itemDTOs = cartItemRepository.findByCart_Id(cart.getId())
                .stream()
                .map(this::convertItemToDTO)
                .collect(Collectors.toList());

        return new CartDTO(
                cart.getId(),
                cart.getUser().getId(),
                cart.getTotalPrice(),
                itemDTOs,
                itemDTOs.size()
        );
    }

    private CartItemDTO convertItemToDTO(CartItem item) {
        Product product = item.getProduct();
        return new CartItemDTO(
                item.getId(),
                product.getId(),
                product.getNameVi(),
                product.getNameEn(),
                product.getPrice(),
                null, // TODO: Add image logic later
                item.getQuantity(),
                product.getPrice() * item.getQuantity()
        );
    }
}
