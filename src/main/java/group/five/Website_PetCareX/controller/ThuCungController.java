package group.five.Website_PetCareX.controller;

import group.five.Website_PetCareX.dto.ResponseData;
import group.five.Website_PetCareX.service.ThuCungService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/thucung")
@Validated
@Slf4j
@Tag(name = "Thu Cung APIs")
@RequiredArgsConstructor
public class ThuCungController {
    private final ThuCungService thuCungService;

    private static final String ERROR_MESSAGE = "errorMessage={}";

    @Operation(
            method = "GET",
            summary = "Lay tat ca thu cung cua khach hang",
            description = "Lay danh sach thu cung theo idKhachHang voi paging"
    )
    @GetMapping("/{idKhachHang}")
    public ResponseData<?> getAllThuCungCuaChu(
            @PathVariable Long idKhachHang,
            @RequestParam(defaultValue = "1") int pageNo,
            @RequestParam(defaultValue = "10") int pageSize) {

        log.info("Lay tat ca thu cung cua idKhachHang={}", idKhachHang);

        return new ResponseData<>(
                HttpStatus.OK.value(),
                "Lay tat ca thu cung cua khach hang",
                thuCungService.getAllThuCungCuaChu(idKhachHang, pageNo, pageSize)
        );
    }
}
