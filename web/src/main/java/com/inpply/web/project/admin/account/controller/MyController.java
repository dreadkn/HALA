package com.inpply.web.project.admin.account.controller;

import com.inpply.common.domain.user.model.User;
import com.inpply.global.exception.BusinessException;
import com.inpply.web.common.user.dto.PasswordDto;
import com.inpply.web.common.user.dto.UserDto;
import com.inpply.web.common.user.repository.UserRepository;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.project.admin.account.dto.MyInfoReqDto;
import com.inpply.web.project.admin.account.service.AccountMngService;
import com.inpply.web.security.AuthenticationHelper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@Controller
@RequestMapping("/admin/my")
@Slf4j
@RequiredArgsConstructor
public class MyController {

    private final AccountMngService accountMngService;
    private final UserRepository userRepository;

    @GetMapping
    public String viewMyPage() {
        return "admin/account/my";
    }

    @GetMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public UserDto.Response getMyInfo() {
        String userId = AuthenticationHelper.getUserId()
            .orElseThrow(() -> new BusinessException("사용자 아이디를 가져올수 없습니다."));
        User user = userRepository.findByUserId(userId)
            .orElseThrow(() -> new EntityNotFoundException("사용자", "userId", userId));
        return new UserDto.Response(user);
    }

    @PatchMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void updateMyInfo(@RequestBody @Valid MyInfoReqDto myInfoReqDto) {
        String userId = AuthenticationHelper.getUserId()
            .orElseThrow(() -> new BusinessException("사용자 ID를 가져올 수 없습니다."));
        accountMngService.updateMyInfo(userId, myInfoReqDto);
    }

    @PatchMapping(value = "/password", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void changeMyPassword(@RequestBody @Valid PasswordDto passwordDto) {
        String userId = AuthenticationHelper.getUserId()
            .orElseThrow(() -> new BusinessException("사용자 ID를 가져올 수 없습니다."));
        accountMngService.changePassword(userId, passwordDto);
    }
}
