package com.inpply.web.project.api.signup.controller;

import com.inpply.common.domain.entity.Member;
import com.inpply.common.domain.repository.MemberRepository;
import com.inpply.global.type.AdminType;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.project.admin.member.normal.dto.MemberDto;
import com.inpply.web.project.admin.member.service.MemberService;
import com.inpply.web.project.api.common.dto.ResultDto;
import com.inpply.web.project.api.signup.dto.SignupApiDto;
import com.inpply.web.project.api.signup.service.EmailCheckService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;
import java.util.concurrent.ThreadLocalRandom;

@Controller
@RequestMapping("/api/v1/signup")
@Slf4j
@RequiredArgsConstructor
public class SignupControllerV1 {



    private final MemberRepository memberRepository;
    private final EmailCheckService emailCheckService;
    private final MemberService memberService;


    /**
     * 회원 등록
     */
    @PostMapping
    @ResponseBody
    public ResultDto.Result signUp(@RequestBody @Valid SignupApiDto.Request request) {

        ResultDto.Result result = new ResultDto.Result();

        try {
            MemberDto requestDto = new MemberDto();
            requestDto.setUserId(request.getUserId());
            requestDto.setPassword(request.getPassword());
            requestDto.setName(request.getName());
            requestDto.setPhone(request.getPhone());
            requestDto.setAdminType(AdminType.USER);
            requestDto.setIsEmailAlarm(request.getIsEmailAlarm());
            requestDto.setIsPushAlarm(request.getIsPushAlarm());
            requestDto.setLanguage1("ko");
            requestDto.setLanguage2("ko");

            result.setSuccess(memberService.save(requestDto));
        } catch (Exception e) {
            result.setFail("계정 등록이 실패하였습니다.");
        }

        return result;
    }

    /**
     * 아이디 찾기
     */
    @PostMapping(value = "/find/id")
    @ResponseBody
    public ResultDto.Result findId(String name, String phone) {

        Member member = memberRepository.findByNameAndPhone(name, phone).orElseThrow(() -> new EntityNotFoundException("콘텐츠", "name", name));

        ResultDto.Result result = new ResultDto.Result();

        result.setResult(true);
        result.setReserve1(member.getUserId());
            return result;
    }
    /**
     * 비밀번호 찾기 메일 발송
     */
    @PostMapping(value = "/find/pw")
    @ResponseBody
    public ResultDto.Result sendFindPasswordEmail(String userId, String name) {

        Member member = memberRepository.findByUserIdAndName(userId, name).orElseThrow(() -> new EntityNotFoundException("콘텐츠", "id", userId));

        ResultDto.Result result = memberService.changePassword(userId);
        if (result.getResult())
            return emailCheckService.sendFindPasswordEmail(member, result);
        else
            return result;
    }
}
