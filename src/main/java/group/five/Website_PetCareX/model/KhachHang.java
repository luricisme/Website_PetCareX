package group.five.Website_PetCareX.model;

import jakarta.persistence.*;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Entity
@Getter
@Setter
@Table(name = "[KhachHang]", schema = "dbo")
public class KhachHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "IdKhachHang")
    private Long idKhachHang;

    @Column(name = "MaKhachHang", nullable = false, unique = true)
    private String maKhachHang;

    @Column(name = "CCCD", length = 12)
    private String cccd;

    @Column(name = "HoTen", length = 255)
    private String hoTen;

    @Column(name = "SoDienThoai", length = 15)
    private String soDienThoai;

    @Column(name = "TongChiTieuNamNay", precision = 15, scale = 2)
    private BigDecimal tongChiTieuNamNay;

    @Column(name = "GioiTinh", length = 10)
    private String gioiTinh; // Nam, Nữ, Khác

    @Column(name = "NgaySinh")
    private LocalDate ngaySinh;

    @Column(name = "DiemLoyalty")
    private Integer diemLoyalty;

    @Column(name = "IdHang")
    private Integer idHang;

    // 1 KhachHang -> 1 Account
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "IdAccount")
    private Account account;

    // 1 KhachHang -> N ThuCung
    @OneToMany(mappedBy = "chu", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<ThuCung> pets;
}
