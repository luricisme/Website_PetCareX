package group.five.Website_PetCareX.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Entity
@Getter
@Setter
@Table(name = "[ThuCung]", schema = "dbo")
public class ThuCung {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "IdThuCung")
    private Long idThuCung;

    @Column(name = "MaThuCung", nullable = false, unique = true)
    private String maThuCung;

    @Column(name = "Ten", length = 255)
    private String ten;

    @Column(name = "Loai", length = 255)
    private String loai;

    @Column(name = "Giong", length = 255)
    private String giong;

    @Column(name = "GioiTinh", length = 10)
    private String gioiTinh; // Nam, Nữ, Khác

    @Column(name = "NgaySinh")
    private LocalDate ngaySinh;

    @Column(name = "TinhTrangSucKhoe", columnDefinition = "NVARCHAR(MAX)")
    private String tinhTrangSucKhoe;

    // N ThuCung -> 1 KhachHang
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "Chu")
    private KhachHang chu;
}
