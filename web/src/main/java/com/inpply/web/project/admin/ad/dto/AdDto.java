package com.inpply.web.project.admin.ad.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.inpply.common.domain.entity.Inspection;
import com.inpply.common.domain.entity.Payment;
import com.inpply.common.domain.file.model.File;
import com.inpply.common.domain.type.AdType;
import com.inpply.common.domain.type.InspectionStatus;
import com.inpply.common.domain.type.PaymentStatus;
import com.inpply.common.domain.type.PeriodType;
import com.inpply.web.global.dto.BaseDto;
import com.inpply.web.project.admin.content.check.dto.CheckDto;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class AdDto extends BaseDto {

    private AdType adType;
    private Boolean isPublic;
    private String companyName;
    private String charger;
    private String tel;
    private String url;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    List<File> files;
    List<File> mobileFiles;
    private Boolean deleted;
    private Payment payment;
    private Inspection inspection;
    private Integer readCount;

    @Data
    public static class Request extends BaseDto {
        private AdType adType;
        private PeriodType periodType;
        private Boolean isPublic;
        @NotBlank(message = "업체명을 입력하세요.")
        private String companyName;
        @NotBlank(message = "담당자를 입력하세요.")
        private String charger;
        @NotBlank(message = "연락처를 입력하세요.")
        private String tel;
        @NotBlank(message = "링크를 입력하세요.")
        private String url;
        @NotNull(message = "광고 시작일을 입력하세요.")
        private LocalDateTime startDate;
        @NotNull(message = "광고 종료일을 입력하세요.")
        private LocalDateTime endDate;
        List<File> files;
        List<File> mobileFiles;
        private CheckDto.PaymentDto payment;
        private CheckDto.InspectionDto inspection;
        private Integer readCount;
    }

    @Data
    public static class PeriodRequest extends BaseDto {
        private AdType adType;
        private PeriodType periodType;
        private Boolean isPublic;
        @NotBlank(message = "업체명을 입력하세요.")
        private String companyName;
        @NotBlank(message = "담당자를 입력하세요.")
        private String charger;
        @NotBlank(message = "연락처를 입력하세요.")
        private String tel;
        @NotBlank(message = "링크를 입력하세요.")
        private String url;
        private LocalDateTime startDate;
        private LocalDateTime endDate;
        List<File> files;
        List<File> mobileFiles;
        private CheckDto.PaymentDto payment;
        private CheckDto.InspectionDto inspection;
        private Integer readCount;

    }

    @Data
    public static class ApiDto extends BaseDto {
        private AdType adType;
        @NotBlank(message = "업체명을 입력하세요.")
        private String companyName;
        @NotBlank(message = "담당자를 입력하세요.")
        private String charger;
        @NotBlank(message = "연락처를 입력하세요.")
        private String tel;
        @NotBlank(message = "링크를 입력하세요.")
        private String url;
        @NotNull(message = "광고 시작일을 입력하세요.")
        private LocalDateTime startDate;
        @NotNull(message = "광고 종료일을 입력하세요.")
        private LocalDateTime endDate;
        List<File> files;
        List<File> mobileFiles;
        private CheckDto.PaymentDto payment;
        private CheckDto.InspectionDto inspection;
    }

    @Data
    public static class ApiListDto extends BaseDto {
        private Long id;
        private AdType adType;
        private String companyName;
        private String charger;
        private String tel;
        private String url;
        private LocalDateTime startDate;
        private LocalDateTime endDate;
        private Long fileId;
        File file;
        InspectionStatus inspectionStatus;
        String inspectionOpinion;
    }
    @Data
    public static class ListItem extends BaseDto {
        private AdType adType;
        private String companyName;
        private LocalDateTime startDate;
        private LocalDateTime endDate;
        private Boolean isPublic;
        private String name;
        private String inspectionName;
        private Integer readCount;
    }

    @Data
    public static class ApiListItem extends BaseDto {
        private String url;
        private File file;
    }

    @Data
    public static class UserListItem extends BaseDto {
        private String url;
        private File file;
    }
}
