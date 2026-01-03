package group.five.Website_PetCareX.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class GetAllChiNhanhKhamBenhResponseDTO {
    private Integer idChiNhanh;
    private String tenChiNhanh;
}
