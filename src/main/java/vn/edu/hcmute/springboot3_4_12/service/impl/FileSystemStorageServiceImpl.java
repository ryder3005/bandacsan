package vn.edu.hcmute.springboot3_4_12.service.impl;


import org.apache.commons.io.FilenameUtils;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import vn.edu.hcmute.springboot3_4_12.config.StorageProperties;
import vn.edu.hcmute.springboot3_4_12.exception.StorageException;
import vn.edu.hcmute.springboot3_4_12.service.IStorageService;

import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@Service
public class FileSystemStorageServiceImpl implements IStorageService {
    private final Path rootLocation;

    public FileSystemStorageServiceImpl(StorageProperties properties) {
        // Lưu trong thư mục project (relative path từ project root)
        String location = properties.getLocation();
        if (location != null && !location.isEmpty() && !Paths.get(location).isAbsolute()) {
            // Nếu là relative path, tạo trong project root
            String projectRoot = System.getProperty("user.dir");
            this.rootLocation = Paths.get(projectRoot, location);
        } else {
            // Nếu là absolute path, dùng như cũ
            this.rootLocation = Paths.get(location != null ? location : "upload");
        }
    }

    @Override
    public void init() {
        try {
            Files.createDirectories(rootLocation);
            System.out.println(rootLocation.toString());
        } catch (Exception e) {
            throw new StorageException("Could not initialize storage: ", e);
        }
    }

    @Override
    public void delete(String storeFilename) throws Exception {
        // Xóa từ thư mục products
        Path productsFile = rootLocation.resolve("products").resolve(Paths.get(storeFilename)).normalize().toAbsolutePath();
        if (Files.exists(productsFile)) {
            Files.delete(productsFile);
            return;
        }
        // Nếu không tìm thấy, thử xóa từ root (backward compatibility)
        Path destinationFile =
                rootLocation.resolve(Paths.get(storeFilename)).normalize().toAbsolutePath();
        if (Files.exists(destinationFile)) {
            Files.delete(destinationFile);
        }
    }

    @Override
    public Path load(String filename) {
        // Tìm trong thư mục products trước
        Path productsFile = rootLocation.resolve("products").resolve(filename);
        if (Files.exists(productsFile)) {
            return productsFile;
        }
        // Nếu không tìm thấy, trả về file ở root (backward compatibility)
        return rootLocation.resolve(filename);
    }

    @Override
    public Resource loadAsResource(String filename) {
        try {
            Path file = load(filename);
            Resource resource = new UrlResource(file.toUri());
            if(resource.exists() || resource.isReadable()) {
                return resource;
            }
            throw new StorageException("Can not read file: " + filename);
        } catch (Exception e) {
            // Re-throw as StorageException
            throw new StorageException("Could not read file: " + filename);
        }
    }

    @Override
    public void store(MultipartFile file, String storeFilename) {
        try {
            if(file.isEmpty()) {
                throw new StorageException("Failed to store empty file");
            }
            
            // Tạo thư mục products nếu chưa có
            Path productsDir = this.rootLocation.resolve("products");
            if (!Files.exists(productsDir)) {
                Files.createDirectories(productsDir);
            }
            
            // Resolve path và lưu vào thư mục products
            Path destinationFile =
                    productsDir.resolve(Paths.get(storeFilename))
                            .normalize().toAbsolutePath();

            // Security check: Prevent "path traversal" by ensuring the destination is within the products directory
            if(!destinationFile.getParent().equals(productsDir.toAbsolutePath())) {
                throw new StorageException("Cannot store file outside products directory");
            }

            try (InputStream inputStream = file.getInputStream()) {
                Files.copy(inputStream, destinationFile,
                        StandardCopyOption.REPLACE_EXISTING);
            }
        } catch (Exception e) {
            throw new StorageException("Failed to store file: ", e);
        }
    }

    @Override
    public String getSorageFilename(MultipartFile file, String id) {
        String ext = FilenameUtils.getExtension(file.getOriginalFilename());
        return "p" + id + "." + ext;
    }

}
