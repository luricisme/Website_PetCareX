package group.five.Website_PetCareX.repository;

import group.five.Website_PetCareX.dto.response.GetAllThuCungCuaChuResponseDTO;
import group.five.Website_PetCareX.model.ThuCung;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ThuCungRepository extends JpaRepository<ThuCung, Long> {
    @Query("""
                SELECT t
                FROM ThuCung t
                WHERE t.chu.idKhachHang = :idKhachHang
            """)
    Page<ThuCung> findAllByKhachHangId(Long idKhachHang, Pageable pageable);
}
