package com.inpply.web.project.admin.calc.month.dto;

import com.inpply.common.domain.file.model.File;
import com.inpply.web.global.dto.BaseDto;
import com.inpply.web.module.banner.type.BannerType;
import lombok.Data;

import javax.persistence.Column;
import javax.validation.constraints.NotEmpty;
import java.time.LocalDate;
import java.util.List;

@Data
public class CalcMonthDto extends BaseDto {

    private LocalDate calcDate;
    private Integer contentCount;
    private Integer contentAmount;
    private Integer adCount;
    private Integer adAmount;
    private Integer subscribeCount;
    private Integer subscribeAmount;
    private Integer totalAmount;
    @Data
    public static class ListItem extends BaseDto {
        private LocalDate calcDate;
        private Integer contentCount;
        private Integer contentAmount;
        private Integer adCount;
        private Integer adAmount;
        private Integer subscribeCount;
        private Integer subscribeAmount;
        private Integer totalAmount;

    }
}
