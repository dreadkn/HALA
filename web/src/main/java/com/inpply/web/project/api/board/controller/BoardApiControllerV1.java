package com.inpply.web.project.api.board.controller;

import com.inpply.web.common.board.dto.ArticleDto;
import com.inpply.web.common.board.repository.ArticleQueryRepository;
import com.inpply.web.common.board.service.ArticleMngService;
import com.inpply.web.common.board.service.BoardMngService;
import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.ad.dto.AdDto;
import com.inpply.web.project.admin.ad.repository.AdQueryRepository;
import com.inpply.web.project.admin.complaint.dto.ComplaintDto;
import com.inpply.web.project.admin.complaint.service.ComplaintService;
import com.inpply.web.project.admin.content.event.dto.EventDto;
import com.inpply.web.project.admin.content.event.repository.EventQueryRepository;
import com.inpply.web.project.admin.content.human.dto.HumanDto;
import com.inpply.web.project.admin.content.human.repository.HumanQueryRepository;
import com.inpply.web.project.admin.content.news.dto.NewsDto;
import com.inpply.web.project.admin.content.news.repository.NewsQueryRepository;
import com.inpply.web.project.admin.content.wedding.dto.WeddingDto;
import com.inpply.web.project.admin.content.wedding.repository.WeddingQueryRepository;
import com.inpply.web.project.admin.content.wedding.service.WeddingService;
import com.inpply.web.project.api.common.dto.ResultDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.transaction.Transactional;
import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/api/v1/board")
@Slf4j
@RequiredArgsConstructor
@Transactional
public class BoardApiControllerV1 {

    private final Long BOARD_NOTICE = 1L;
    private final Long BOARD_FAQ = 2L;
    private final ArticleMngService articleMngService;
    private final ComplaintService complaintService;

    /**
     * 공지사항 목록 조회
     */
    @GetMapping(value = "/notice")
    @ResponseBody
    public Page<? extends ArticleDto.Detail> getListByNotice(@PageableDefault(direction = Sort.Direction.DESC, sort = "createdDate") Pageable pageable, Search search) {

        Page<? extends ArticleDto.Detail> page = articleMngService.getArticles(BOARD_NOTICE, pageable, search, false);

        return page;
    }

    /**
     * 공지사항 상세 조회
     */
    @GetMapping(value = "/notice/detail")
    @ResponseBody
    public ArticleDto.Detail getNotice(Long id) {

        ArticleDto.Detail item = articleMngService.getArticle(id);

        return item;
    }

    /**
     * FAQ 목록 조회조회
     */
    @GetMapping(value = "/faq")
    @ResponseBody
    public Page<? extends ArticleDto.Detail> getListByFaq(@PageableDefault(direction = Sort.Direction.DESC, sort = "createdDate") Pageable pageable, Search search) {

        Page<? extends ArticleDto.Detail> page = articleMngService.getArticles(BOARD_FAQ, pageable, search, false);

        return page;
    }

    /**
     * 불편신고 등록
     */
    @PostMapping("/broken")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public ResultDto.Result saveBroken(@RequestBody @Valid ComplaintDto complaintDto) {
        ResultDto.Result result = new ResultDto.Result();

        try{

            Long id = complaintService.save(complaintDto);

            result.setSuccess(id);

        } catch (Exception e){
            result.setFail("등록중 오류가 발생했습니다.");
        }

        return result;
    }

}
