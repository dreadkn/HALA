package com.inpply.web.project.api.member.controller;

import com.inpply.common.domain.entity.Member;
import com.inpply.common.domain.repository.MemberRepository;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.content.check.dto.CheckDto;
import com.inpply.web.project.admin.content.check.repository.CheckQueryRepository;
import com.inpply.web.project.admin.subscribe.dto.SubscribeDto;
import com.inpply.web.project.admin.subscribe.repository.SubscribeQueryRepository;
import com.inpply.web.project.api.common.dto.ResultDto;
import com.inpply.web.project.api.member.dto.MemberApiDto;
import com.inpply.web.project.api.member.service.MemberApiService;
import com.inpply.web.security.AuthenticationHelper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Controller
@RequestMapping("/api/v1/member")
@Slf4j
@RequiredArgsConstructor
public class MemberApiControllerV1 {

    private final MemberRepository memberRepository;

    private final MemberApiService memberApiService;
    private final SubscribeQueryRepository subscribeQueryRepository;
    private final CheckQueryRepository checkQueryRepository;

    /**
     * 내정보 확인
     */
    @GetMapping()
    @ResponseBody
    public MemberApiDto.DetailDto getInfo() {
        return memberApiService.getMemberInfo();
    }


    /**
     * 내정보 업데이트
     */
    @PostMapping()
    @ResponseBody
    public ResultDto.Result updateMember(@RequestBody MemberApiDto.UpdateDto updateDto) {

        return memberApiService.updateMember(updateDto);
    }

    /**
     * 비밀번호 변경
     */
    @PostMapping(value = "/change/pw")
    @ResponseBody
    public ResultDto.Result changePw(@RequestBody MemberApiDto.ChangePwDto changePwDto) {

        return memberApiService.changePw(changePwDto);
    }


    /**
     * 회원 탈퇴
     */
    @PostMapping(value = "/set/withdraw")
    @ResponseBody
    public ResultDto.Result setWithDraw() {
        return memberApiService.updateWithDraw();
    }


    /**
     * 회원 - 방문자 연계
     */
    @PostMapping(value = "/set/visitor")
    @ResponseBody
    public ResultDto.Result setWithVisitor(@RequestParam("visitorToken") String visitorToken) {

        return memberApiService.updateVisitor(visitorToken);
    }

    /**
     * 구독 등록
     */
    @PostMapping("/subscribe")
    @ResponseBody
    public ResultDto.Result subscribe(@RequestBody SubscribeDto.Request request) {

        return memberApiService.subscribe(request);
    }

    /**
     * 내 구독정보 조회
     */
    @GetMapping("/subscribe")
    @ResponseBody
    public SubscribeDto.MemberSubscribeDto getSubscribe(@RequestBody SubscribeDto.Request request) {

        SubscribeDto.MemberSubscribeDto subscribeDto =  subscribeQueryRepository.findByMember(AuthenticationHelper.getId().orElseGet(() -> -1l))
                .orElseGet(() -> new SubscribeDto.MemberSubscribeDto());

        return subscribeDto;
    }

    /**
     * 내가 등록한 콘텐츠 현황
     */
    @GetMapping(value = "/present", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public CheckDto.StatsDto getContentStats() {

        return checkQueryRepository.findStatsByMember(AuthenticationHelper.getId().orElseGet(() -> -1l)).orElseGet(() -> new CheckDto.StatsDto());
    }

}
