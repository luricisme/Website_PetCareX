package group.five.Website_PetCareX.controller;

import group.five.Website_PetCareX.dto.ResponseData;
import group.five.Website_PetCareX.service.ChiNhanhService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/chinhanh")
@Validated
@Slf4j
@Tag(name = "Chi Nhanh APIs")
@RequiredArgsConstructor
public class ChiNhanhController {
    private final ChiNhanhService chiNhanhService;

    private static final String ERROR_MESSAGE = "errorMessage={}";

    @Operation(method = "GET", summary = "Lay tat ca chi nhanh kham benh", description = "Lay tat ca chi nhanh voi dich vu kham benh")
    @GetMapping(value = "/khambenh")
    public ResponseData<?> getAllChiNhanhKhamBenh(@RequestParam(defaultValue = "1") int pageNo, @RequestParam(defaultValue = "10") int pageSize) {
        log.info("Lay tat ca chi nhanh kham benh");
        return new ResponseData<>(HttpStatus.OK.value(), "Lay tat ca chi nhanh kham benh", chiNhanhService.getAllChiNhanhKhamBenh(pageNo, pageSize));
    }
}
