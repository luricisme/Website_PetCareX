package group.five.Website_PetCareX.dto;

import lombok.*;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PageResponseDetail<T> {
    private int pageNo;
    private int pageSize;
    private int totalPage;
    private Long totalElements;
    private T items;
}
