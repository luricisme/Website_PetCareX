package group.five.Website_PetCareX.repository;

import group.five.Website_PetCareX.model.ChiNhanh;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ChiNhanhRepository extends JpaRepository<ChiNhanh, Integer> {
    @Query("""
            SELECT cn 
            FROM ChiNhanh cn 
            JOIN ChiNhanhDichVu cdv ON cn.idChiNhanh = cdv.idChiNhanh
            JOIN DichVu dv ON cdv.idDichVu = dv.idDichVu
            WHERE dv.tenDichVu = :tenDichVu
            """)
    Page<ChiNhanh> findChiNhanhByDichVu(String tenDichVu, Pageable pageable);
}
