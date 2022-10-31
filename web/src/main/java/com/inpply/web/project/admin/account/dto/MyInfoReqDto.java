package com.inpply.web.project.admin.account.dto;

import com.inpply.web.project.admin.account.validation.ValidMyInfo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ValidMyInfo
public class MyInfoReqDto {

    @NotBlank(message = "아이디를 입력해주세요.")
    private String userId;
    @NotBlank(message = "이름을 입력해주세요.")
    private String name;
    @NotBlank(message = "전화번호를 입력해주세요.")
    private String phone;
    @Email
    @NotBlank(message = "이메일을 입력해주세요.")
    private String email;
}
