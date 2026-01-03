package group.five.Website_PetCareX.model.composite_keys;

import java.io.Serializable;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode
public class ChiNhanhDichVuId implements Serializable {
    private Integer idChiNhanh;
    private Integer idDichVu;
}
