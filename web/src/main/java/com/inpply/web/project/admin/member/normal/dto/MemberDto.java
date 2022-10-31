package com.inpply.web.project.admin.member.normal.dto;

import com.inpply.common.converter.BooleanToYNConverter;
import com.inpply.common.domain.file.model.File;
import com.inpply.web.common.user.dto.UserDto;
import com.inpply.web.global.dto.BaseDto;
import com.inpply.web.module.banner.type.BannerType;
import com.inpply.web.project.admin.enc.admin.dto.AdminDto;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Convert;
import javax.validation.constraints.NotEmpty;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class MemberDto extends AdminDto {

    Integer contentCount;
    Integer adCount;
    Boolean isSubscribe;
    LocalDateTime lastLoginDate;
    Integer subscribeUpdateCount;
    LocalDateTime withdrawalDate;
    Boolean isWithdrawal;
    Boolean isEmailAlarm;
    Boolean isPushAlarm;

    /**이메일 허용여부*/
    Boolean isAgreeEmail;
    Boolean isAgreePush;

    @Data
    public static class UserRequest extends AdminDto {

    }
    @Data
    public static class ListItem extends AdminDto {

        Integer contentCount;
        Integer adCount;
        LocalDateTime lastLoginDate;
        LocalDateTime withdrawalDate;
    }
}
