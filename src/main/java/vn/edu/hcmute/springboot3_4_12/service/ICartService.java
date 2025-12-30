package vn.edu.hcmute.springboot3_4_12.service;

import vn.edu.hcmute.springboot3_4_12.dto.CartDTO;
import vn.edu.hcmute.springboot3_4_12.dto.CartRequestDTO;

public interface ICartService {
    CartDTO getCartByUserId(Long userId);
    CartDTO addToCart(Long userId, CartRequestDTO request);
    CartDTO updateCartItem(Long userId, Long itemId, Integer quantity);
    void removeCartItem(Long userId, Long itemId);
    void clearCart(Long userId);
}
