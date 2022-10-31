package com.inpply.web.user.controller;

import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.content.event.dto.EventDto;
import com.inpply.web.project.admin.content.event.repository.EventQueryRepository;
import com.inpply.web.project.admin.content.human.dto.HumanDto;
import com.inpply.web.project.admin.content.human.repository.HumanQueryRepository;
import com.inpply.web.project.admin.content.news.dto.NewsDto;
import com.inpply.web.project.admin.content.news.repository.NewsQueryRepository;
import com.inpply.web.project.admin.content.wedding.dto.WeddingDto;
import com.inpply.web.project.admin.content.wedding.repository.WeddingQueryRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/")
@RequiredArgsConstructor
@Slf4j
public class UserHomeController {

    private final NewsQueryRepository newsQueryRepository;

    private final EventQueryRepository eventQueryRepository;
    private final WeddingQueryRepository weddingQueryRepository;
    private final HumanQueryRepository humanQueryRepository;

    @GetMapping
    public String viewHome(Model model) {
        return "user/index";
    }

    @GetMapping(value = "/main/news/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Page<NewsDto.ListItem> getListByNews(@PageableDefault(size = 7, direction = Sort.Direction.DESC, sort = "createdDate") Pageable pageable, Search search) {
        log.debug("Search: {}", search);

        Page<NewsDto.ListItem> page = newsQueryRepository.findAll(pageable, search);

        return page;
    }

    @GetMapping(value = "/main/event/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Page<EventDto.ListItem> getListByEvent(@PageableDefault(direction = Sort.Direction.DESC, sort = "createdDate") Pageable pageable, Search search) {
        log.debug("Search: {}", search);

        Page<EventDto.ListItem> page = eventQueryRepository.findAllByPublic(pageable, search);

        return page;
    }

    @GetMapping(value = "/main/wedding/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Page<WeddingDto> getListByWedding(@PageableDefault(size = 4) Pageable pageable, Search search) {
        log.debug("Search: {}", search);

        Page<WeddingDto> page = weddingQueryRepository.findAllByWedding(pageable, search);

        return page;
    }

    @GetMapping(value = "/main/death/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Page<WeddingDto> getListByDeath(@PageableDefault(size = 3) Pageable pageable, Search search) {
        log.debug("Search: {}", search);

        Page<WeddingDto> page = weddingQueryRepository.findAllByDeath(pageable, search);

        return page;
    }

    @GetMapping(value = "/main/person/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Page<WeddingDto> getListByPerson(@PageableDefault(size = 6) Pageable pageable, Search search) {
        log.debug("Search: {}", search);

        Page<WeddingDto> page = weddingQueryRepository.findAllByPerson(pageable, search);

        return page;
    }

    @GetMapping(value = "/main/human/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Page<HumanDto.ListItem> getListByHuman(@PageableDefault(direction = Sort.Direction.DESC, sort = "createdDate") Pageable pageable, Search search) {
        log.debug("Search: {}", search);

        Page<HumanDto.ListItem> page = humanQueryRepository.findAllByPublic(pageable, search);

        return page;
    }
    
}
