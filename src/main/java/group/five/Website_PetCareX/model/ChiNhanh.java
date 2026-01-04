package group.five.Website_PetCareX.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "[ChiNhanh]", schema = "dbo")
public class ChiNhanh {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idChiNhanh;

    @Column(name = "MaChiNhanh", nullable = false, unique = true)
    private String maChiNhanh;

    @Column(name = "TenChiNhanh")
    private String tenChiNhanh;

    @Column(name = "DiaChi")
    private String diaChi;

    @Column(name = "SoDienThoai")
    private String soDienThoai;

    @Column(name = "GioMoCua")
    private String gioMoCua;

    @Column(name = "GioDongCua")
    private String gioDongCua;
}

