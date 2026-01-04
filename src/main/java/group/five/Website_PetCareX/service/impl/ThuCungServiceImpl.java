package group.five.Website_PetCareX.service.impl;

import group.five.Website_PetCareX.dto.PageResponseDetail;
import group.five.Website_PetCareX.dto.response.GetAllChiNhanhKhamBenhResponseDTO;
import group.five.Website_PetCareX.dto.response.GetAllThuCungCuaChuResponseDTO;
import group.five.Website_PetCareX.model.ThuCung;
import group.five.Website_PetCareX.repository.ThuCungRepository;
import group.five.Website_PetCareX.service.ThuCungService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ThuCungServiceImpl implements ThuCungService {
    private final ThuCungRepository thuCungRepository;

    @Override
    public PageResponseDetail<List<GetAllThuCungCuaChuResponseDTO>> getAllThuCungCuaChu(Long idKhachHang, int pageNo, int pageSize) {
        Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
        Page<ThuCung> page = thuCungRepository.findAllByKhachHangId(idKhachHang, pageable);

        List<GetAllThuCungCuaChuResponseDTO> items = page.getContent()
                .stream()
                .map(tc -> new GetAllThuCungCuaChuResponseDTO(tc.getIdThuCung(), tc.getMaThuCung(), tc.getTen()))
                .collect(Collectors.toList());

        return PageResponseDetail.<List<GetAllThuCungCuaChuResponseDTO>>builder()
                .pageNo(page.getNumber() + 1)
                .pageSize(page.getSize())
                .totalPage(page.getTotalPages())
                .totalElements(page.getTotalElements())
                .items(items)
                .build();
    }
}
