package vn.edu.hcmute.springboot3_4_12;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import vn.edu.hcmute.springboot3_4_12.config.CustomSiteMeshFilter;
import vn.edu.hcmute.springboot3_4_12.config.StorageProperties;
import vn.edu.hcmute.springboot3_4_12.service.IStorageService;

@EnableConfigurationProperties(StorageProperties.class)

@SpringBootApplication
public class Springboot3412Application {

    public static void main(String[] args) {

        SpringApplication.run(Springboot3412Application.class, args);
    }

    @Bean
    CommandLineRunner init(IStorageService storageService) {
        return (args -> {
            storageService.init();
        });
    }
}
