package com.inpply.web.project.api.visitor.controller;

import com.inpply.common.domain.entity.Visitor;
import com.inpply.common.domain.repository.VisitorActionLogRepository;
import com.inpply.common.domain.repository.VisitorFcmRepository;
import com.inpply.common.domain.repository.VisitorRepository;
import com.inpply.common.domain.repository.VisitorSearchRepository;
import com.inpply.web.project.api.common.dto.ResultDto;
import com.inpply.web.project.api.visitor.dto.*;
import com.inpply.web.project.api.visitor.repository.VisitorApiQueryRepository;
import com.inpply.web.project.api.visitor.service.VisitorApiService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/api/v1/visitor")
@Slf4j
@RequiredArgsConstructor
public class VisitorApiControllerV1 {

    private final VisitorRepository visitorRepository;
    private final VisitorFcmRepository visitorFcmRepository;
    private final VisitorSearchRepository visitorSearchRepository;
    private final VisitorActionLogRepository visitorActionLogRepository;

    private final VisitorApiService visitorApiService;

    private final VisitorApiQueryRepository visitorApiQueryRepository;

    /**
     * 방문자 등록
     */
    @PostMapping
    @ResponseBody
    public VisitorApiDto.Result registerVisitor() {

        return visitorApiService.registerVisitor();
    }

    /**
     * 방문자 조회
     */
    @GetMapping
    @ResponseBody
    public VisitorApiDto.Info getVisitor(@RequestParam("visitorToken")String visitorToken) {

        Visitor visitor = visitorRepository.findByVisitorToken(visitorToken).orElse(null);

        return new VisitorApiDto.Info(visitor);
    }

    /**
     * 방문자 FCM 토큰 등록
     */
    @PostMapping(value = "/fcm")
    @ResponseBody
    public ResultDto.Result registerFcm(VisitorFcmApiDto.Register register) {
        return visitorApiService.registerFcm(register);
    }

    /**
     * 검색어 내역 조회
     */
    @GetMapping(value = "/search")
    @ResponseBody
    public List<VisitorSearchApiDto.List> getVisitorSearchkeywords(String visitorToken) {
        return visitorApiQueryRepository.findKeywordList(visitorToken);
    }

    /**
     * 액션 로그 수집
     */
    @PostMapping(value = "/log")
    @ResponseBody
    public ResultDto.Result registerLog(@RequestBody VisitorActionLogApiDto.Register register) {
        return visitorApiService.registerActionLog(register);
    }

}
