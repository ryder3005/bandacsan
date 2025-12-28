package vn.edu.hcmute.springboot3_4_12.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

@Data
@ConfigurationProperties("storage")
public class StorageProperties {
    private String location;
}
