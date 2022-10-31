package com.inpply.web.project.admin.subscribe.dto;

import com.inpply.common.domain.entity.Member;
import com.inpply.common.domain.entity.Payment;
import com.inpply.common.domain.entity.SubscribeBenefit;
import com.inpply.common.domain.file.model.File;
import com.inpply.web.global.dto.BaseDto;
import com.inpply.web.module.banner.type.BannerType;
import com.inpply.web.project.admin.content.check.dto.CheckDto;
import com.inpply.web.project.admin.enc.policy.dto.SubscribePolicyDto;
import com.inpply.web.project.admin.member.normal.dto.MemberDto;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.OneToOne;
import javax.validation.constraints.NotEmpty;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class SubscribeDto extends BaseDto {

    private Member member;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private String charger;
    private String tel;
    private Integer contentLeftCount;
    private Integer adLeftCount;
    private Payment payment;
    private SubscribeBenefit subscribeBenefit;

    @Data
    public static class Request extends BaseDto {
        private LocalDateTime startDate;
        private LocalDateTime endDate;
        private String charger;
        private String tel;
        private Integer contentLeftCount;
        private Integer adLeftCount;
        private CheckDto.PaymentDto payment;
    }

    @Data
    public static class ListItem extends BaseDto {
        private LocalDateTime startDate;
        private LocalDateTime endDate;
        private String name;
        Integer subscribeUpdateCount;
    }

    @Data
    public static class SubscribeBenefitDto extends BaseDto {
        private Integer contentCount;
        private Integer adCount;
    }

    @Data
    public static class MemberSubscribeDto extends BaseDto {
        private LocalDateTime startDate;
        private LocalDateTime endDate;
        private String charger;
        private String tel;
        private Integer contentLeftCount;
        private Integer adLeftCount;
        private Payment payment;
        private SubscribeBenefit subscribeBenefit;
    }
}
