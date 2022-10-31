package com.inpply.web.project.admin.enc.policy.dto;

import com.inpply.common.domain.file.model.File;
import com.inpply.common.domain.type.PeriodType;
import com.inpply.global.model.Money;
import com.inpply.web.global.dto.BaseDto;
import com.inpply.web.module.banner.type.BannerType;
import lombok.Data;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class SubscribePolicyDto extends BaseDto {

    @NotNull(message = "적용 시작일을 입력하세요.")
    private LocalDateTime startDate;
    @NotNull(message = "적용 종료일을 입력하세요.")
    private LocalDateTime endDate;
    private PeriodType periodType;
    @NotNull(message = "콘텐츠 등록건수를 입력하세요.")
    private Integer contentCount;
    @NotNull(message = "광고 1개월 등록건수를 입력하세요.")
    private Integer adCount;
    @NotNull(message = "요금을 입력하세요.")
    private Money price;

    @Data
    public static class ListItem extends BaseDto {
        private LocalDateTime startDate;
        private LocalDateTime endDate;
        private PeriodType periodType;
        private Integer contentCount;
        private Integer adCount;
        private Money price;
    }
}
