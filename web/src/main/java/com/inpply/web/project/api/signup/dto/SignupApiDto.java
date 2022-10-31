package com.inpply.web.project.api.signup.dto;

import com.inpply.common.converter.BooleanToYNConverter;
import com.inpply.common.domain.entity.Member;
import com.inpply.common.domain.user.model.User;
import com.inpply.web.project.api.signup.validation.ValidSignup;
import lombok.Data;
import org.apache.xmlbeans.impl.xb.xsdschema.Attribute;

import javax.persistence.Column;
import javax.persistence.Convert;
import javax.validation.constraints.NotEmpty;

@Data
public class SignupApiDto {

    @Data
    @ValidSignup
    public static class Request  {

        @NotEmpty(message = "비밀번호를 입력하세요.")
        String password;
        @NotEmpty(message = "이메일 주소를 입력하세요.")
        String userId;
        String name;
        String phone;
        /**푸시 허용여부*/
        Boolean isPushAlarm;
        /**이메일 허용여부*/
        Boolean isEmailAlarm;
    }
}
