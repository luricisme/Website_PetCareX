package group.five.Website_PetCareX.configuration;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class AppConfig implements WebMvcConfigurer {
    @Value("${server.frontend_host_dev}")
    private String FRONTEND_HOST_DEV;

    @Value("${server.frontend_host_prod}")
    private String FRONTEND_HOST_PROD;

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**") // Allow all endpoints on server
                .allowCredentials(true) // Allow to send cookie or authorization token
                .allowedOrigins(
                        FRONTEND_HOST_DEV,
                        FRONTEND_HOST_PROD
                )
                .allowedMethods("GET", "POST", "PUT", "PATCH", "DELETE")
                .allowedHeaders("*");
    }
}
