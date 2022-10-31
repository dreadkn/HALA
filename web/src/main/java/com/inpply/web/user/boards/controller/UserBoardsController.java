package com.inpply.web.user.boards.controller;

import com.inpply.web.common.board.domain.Board;
import com.inpply.web.common.board.dto.ArticleDto;
import com.inpply.web.common.board.repository.ArticleQueryRepository;
import com.inpply.web.common.board.repository.ArticleRepository;
import com.inpply.web.common.board.repository.BoardRepository;
import com.inpply.web.common.board.service.ArticleMngService;
import com.inpply.web.common.board.service.BoardMngService;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("boards")
@RequiredArgsConstructor
@Slf4j
public class UserBoardsController {

    private final Long BOARD_NOTICE = 1l;
    private final Long BOARD_FAQ = 2l;
    private final ArticleMngService articleMngService;
    private final ArticleRepository articleRepository;
    private final BoardMngService boardMngService;
    private final ModelMapper modelMapper;
    private final ArticleQueryRepository articleQueryRepository;
    private final BoardRepository boardRepository;


    @GetMapping(value = "notice")
    public String noticeList(Model model) {
        return "/user/boards/notice-list";
    }

    @GetMapping(value = "/notice/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Page<? extends ArticleDto.Detail> getListNotice(@PageableDefault Pageable pageable, Search search) {
        log.debug("Search: {}", search);

        Page<? extends ArticleDto.Detail> articles = articleMngService.getArticles(BOARD_NOTICE, pageable, search, true);

        return articles;
    }

    @GetMapping(value = "notice/{id}")
    public String noticeDetail(Model model, @PathVariable Long id) {
        model.addAttribute("id", id);
        return "/user/boards/notice-detail";
    }

    /**
     * 글 상세 조회.
     */
    @GetMapping(value = "/notice/detail/{articleId}", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ArticleDto.Detail getNotice(@PathVariable Long articleId) {
        return articleMngService.getArticle(articleId);
    }

    @GetMapping(value = "/notice/prev/{id}", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ArticleDto.Detail getPrev(@PathVariable Long id) {

        Board board = boardRepository.findById(BOARD_NOTICE)
                .orElseThrow(() -> new EntityNotFoundException("게시판", "boardId", BOARD_NOTICE));

        ArticleDto.Detail detail = articleQueryRepository.findByPrev(board, id);
        return detail;
    }

    @GetMapping(value = "/notice/next/{id}", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ArticleDto.Detail getNext(@PathVariable Long id) {

        Board board = boardRepository.findById(BOARD_NOTICE)
                .orElseThrow(() -> new EntityNotFoundException("게시판", "boardId", BOARD_NOTICE));

        ArticleDto.Detail detail = articleQueryRepository.findByNext(board, id);
        return detail;
    }

    @GetMapping(value = "faq")
    public String faqList(Model model) {
        return "/user/boards/faq-list";
    }

    @GetMapping(value = "/faq/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Page<? extends ArticleDto.Detail> getListFaq(@PageableDefault Pageable pageable, Search search) {
        log.debug("Search: {}", search);

        Page<? extends ArticleDto.Detail> articles = articleMngService.getArticles(BOARD_FAQ, pageable, search, true);

        return articles;
    }
}
