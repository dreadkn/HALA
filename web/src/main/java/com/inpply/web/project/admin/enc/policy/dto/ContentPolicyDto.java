package com.inpply.web.project.admin.enc.policy.dto;

import com.inpply.common.domain.file.model.File;
import com.inpply.common.domain.type.ContentType;
import com.inpply.global.converter.MoneyAttributeConverter;
import com.inpply.global.model.Money;
import com.inpply.web.global.dto.BaseDto;
import com.inpply.web.module.banner.type.BannerType;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Convert;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class ContentPolicyDto extends BaseDto {

    @NotNull(message = "적용 시작일을 입력하세요.")
    private LocalDateTime startDate;
    @NotNull(message = "적용 종료일을 입력하세요.")
    private LocalDateTime endDate;
    private ContentType contentType;
    @NotNull(message = "요금을 입력하세요.")
    private Money price;

    @Data
    public static class ListItem extends BaseDto {
        private LocalDateTime startDate;
        private LocalDateTime endDate;
        private ContentType contentType;
        private Money price;
    }
}
