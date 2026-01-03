package group.five.Website_PetCareX.service;

import group.five.Website_PetCareX.dto.PageResponseDetail;
import group.five.Website_PetCareX.dto.response.GetAllChiNhanhKhamBenhResponseDTO;

import java.util.List;

public interface ChiNhanhService {
    public PageResponseDetail<List<GetAllChiNhanhKhamBenhResponseDTO>> getAllChiNhanhKhamBenh(int pageNo, int pageSize);
}
