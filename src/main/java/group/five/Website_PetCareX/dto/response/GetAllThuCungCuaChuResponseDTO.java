package group.five.Website_PetCareX.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class GetAllThuCungCuaChuResponseDTO {
    private Long idThuCung;
    private String maThuCung;
    private String ten;
}
