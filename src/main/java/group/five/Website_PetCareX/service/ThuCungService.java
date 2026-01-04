package group.five.Website_PetCareX.service;

import group.five.Website_PetCareX.dto.PageResponseDetail;
import group.five.Website_PetCareX.dto.response.GetAllThuCungCuaChuResponseDTO;

import java.util.List;

public interface ThuCungService {
    public PageResponseDetail<List<GetAllThuCungCuaChuResponseDTO>> getAllThuCungCuaChu(Long idKhachHang, int pageNo, int pageSize);
}
