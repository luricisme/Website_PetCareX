package group.five.Website_PetCareX.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Tag(name = "Test API", description = "API test đơn giản trả về Hello World")
public class TestController {
    @GetMapping("/hello")
    @Operation(summary = "Hello API", description = "Trả về chuỗi Hello World để test")
    public String hello() {
        return "Hello World";
    }
}
