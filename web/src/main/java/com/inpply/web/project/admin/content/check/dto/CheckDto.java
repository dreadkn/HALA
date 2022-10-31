package com.inpply.web.project.admin.content.check.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.inpply.common.domain.entity.Inspection;
import com.inpply.common.domain.entity.Payment;
import com.inpply.common.domain.file.model.File;
import com.inpply.common.domain.type.ContentType;
import com.inpply.common.domain.type.InspectionStatus;
import com.inpply.common.domain.type.PaymentStatus;
import com.inpply.common.domain.type.PaymentType;
import com.inpply.common.domain.user.model.User;
import com.inpply.global.converter.MoneyAttributeConverter;
import com.inpply.global.model.Money;
import com.inpply.web.common.user.dto.UserDto;
import com.inpply.web.global.dto.BaseDto;
import com.inpply.web.module.banner.type.BannerType;
import com.inpply.web.project.admin.content.news.dto.NewsDto;
import lombok.Builder;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class CheckDto extends BaseDto {

    private ContentType contentType;
    private Long contentId;
    private Payment payment;
    private Inspection inspection;

    @Data
    public static class Request extends BaseDto {
        private ContentType contentType;
        private Long contentId;
        private PaymentDto payment;
        private InspectionDto inspection;
    }

    @Data
    public static class ApiListItem extends BaseDto {
        private ContentType contentType;
        private Long contentId;
        private String newsTitle;
        private String eventTitle;
        private String congratulationsTitle;
        private String humanTitle;
        private String name;
        private InspectionStatus inspectionStatus;
        private String inspectionOpinion;
    }

    @Data
    public static class ListItem extends BaseDto {
        private ContentType contentType;
        private Long contentId;
        private String newsTitle;
        private String eventTitle;
        private String congratulationsTitle;
        private String humanTitle;
        private String name;
        private String inspectionOpinion;
        private InspectionStatus inspectionStatus;
        private LocalDateTime newsCreatedDate;
        private LocalDateTime eventCreatedDate;
        private LocalDateTime congratulationsCreatedDate;
        private LocalDateTime humanCreatedDate;
        private String newsCreatedName;
        private String eventCreatedName;
        private String congratulationsCreatedName;
        private String humanCreatedName;
        private Long newsFileId;
        private Long eventFileId;
        private Long congratulationsFileId;
        private Long humanFileId;
    }

    @Data
    public static class PaymentDto extends BaseDto {
        private PaymentType paymentType;
        private PaymentStatus paymentStatus;
        private String approveNumber;
        private Money price;
    }

    @Data
    public static class InspectionDto extends BaseDto {
        private UserDto inspectionUser;
        @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
        private LocalDateTime inspectionDate;
        private String inspectionOpinion;
        private InspectionStatus inspectionStatus;
    }

    @Data
    public static class StatsDto extends BaseDto {
        private Integer newsCount;
        private Integer eventCount;
        private Integer congratulationsCount;
        private Integer humanCount;
        private Integer waitCount;
        private Integer rejectCount;
        private Integer approveCount;
    }


}
