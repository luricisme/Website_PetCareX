package group.five.Website_PetCareX.service.impl;

import group.five.Website_PetCareX.dto.PageResponseDetail;
import group.five.Website_PetCareX.dto.response.GetAllChiNhanhKhamBenhResponseDTO;
import group.five.Website_PetCareX.model.ChiNhanh;
import group.five.Website_PetCareX.repository.ChiNhanhRepository;
import group.five.Website_PetCareX.service.ChiNhanhService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ChiNhanhServiceImpl implements ChiNhanhService {
    private final ChiNhanhRepository chiNhanhRepository;

    @Override
    public PageResponseDetail<List<GetAllChiNhanhKhamBenhResponseDTO>> getAllChiNhanhKhamBenh(int pageNo, int pageSize) {
        Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
        Page<ChiNhanh> page = chiNhanhRepository.findChiNhanhByDichVu("Khám bệnh", pageable);

        List<GetAllChiNhanhKhamBenhResponseDTO> items = page.getContent()
                .stream()
                .map(cn -> new GetAllChiNhanhKhamBenhResponseDTO(cn.getIdChiNhanh(), cn.getTenChiNhanh()))
                .collect(Collectors.toList());

        return PageResponseDetail.<List<GetAllChiNhanhKhamBenhResponseDTO>>builder()
                .pageNo(page.getNumber())
                .pageSize(page.getSize())
                .totalPage(page.getTotalPages())
                .totalElements(page.getTotalElements())
                .items(items)
                .build();
    }

}
