package group.five.Website_PetCareX.model;

import group.five.Website_PetCareX.model.composite_keys.ChiNhanhDichVuId;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;

@Entity
@Table(name = "[ChiNhanh_DichVu]", schema = "dbo")
@IdClass(ChiNhanhDichVuId.class) // composite key
public class ChiNhanhDichVu {
    @Id
    private Long idChiNhanh;

    @Id
    private Long idDichVu;
}
