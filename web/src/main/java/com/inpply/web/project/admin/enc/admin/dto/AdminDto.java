package com.inpply.web.project.admin.enc.admin.dto;

import com.inpply.common.domain.user.type.ApproveType;
import com.inpply.global.type.AdminType;
import com.inpply.web.common.user.validation.ValidPassword;
import com.inpply.web.common.user.validation.ValidUserId;
import com.inpply.web.global.dto.BaseDto;
import com.inpply.web.global.validator.OnCreate;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotBlank;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class AdminDto extends BaseDto {

    @ValidUserId(groups = OnCreate.class)
    @NotBlank(message = "아이디를 입력하세요.")
    private String userId;
    @ValidPassword(groups = OnCreate.class)
    protected String password;
    @NotBlank(message = "이름을 입력하세요.")
    protected String name;
    @NotBlank(message = "연락처를 입력하세요.")
    protected String phone;
    @NotBlank(message = "이메일을 입력하세요.")
    protected String email;

    protected boolean enabled;

    protected String refreshToken;
    protected String fcmToken;

    private AdminType adminType;

    private String language1;

    private String language2;

    private String paymentCard;

    private ApproveType approveType;

    private String zipCode;

    private String addressRoad;
    private String addressJibun;

}
