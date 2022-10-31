package com.inpply.web.project.admin.content.news.controller;

import com.inpply.common.domain.type.ContentType;
import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.content.check.dto.CheckDto;
import com.inpply.web.project.admin.content.check.service.CheckService;
import com.inpply.web.project.admin.content.news.dto.NewsDto;
import com.inpply.web.project.admin.content.news.repository.NewsQueryRepository;
import com.inpply.web.project.admin.content.news.service.NewsService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@Controller
@RequestMapping("/admin/news")
@Slf4j
@RequiredArgsConstructor
public class NewsController {

    private final NewsQueryRepository newsQueryRepository;

    private final NewsService newsService;
    private final CheckService checkService;

    @GetMapping
    public String viewList(@PageableDefault Pageable pageable, Search search, Model model) {
        return "admin/news/news-list";
    }

    @GetMapping(value = "/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public DataTable.Returned<NewsDto.ListItem> getList(DataTable.Sent sent, Search search) {
        log.debug("DataTables: {}", sent);
        log.debug("Search: {}", search);

        Page<NewsDto.ListItem> page = newsQueryRepository.findAll(sent.getPageable(), search);

        return new DataTable.Returned<>(sent, page);
    }

    @GetMapping({"/form", "/{id}"})
    public String viewForm(@PathVariable(required = false) Long id, Model model) {

        model.addAttribute("id", id);

        return "admin/news/news-form";
    }

    @GetMapping(value = "/detail/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public NewsDto get(@PathVariable Long id) {
        return newsService.getDto(id);
    }

    @PostMapping
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Long save(@RequestBody @Valid NewsDto newsDto) {

        return newsService.save(newsDto);
    }

    @PutMapping("/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.NO_CONTENT)
    public Long update(@PathVariable Long id, @RequestBody @Valid NewsDto newsDto) {

        return newsService.update(id, newsDto);
    }

    @DeleteMapping("/{id}")
    @ResponseBody
    public void delete(@PathVariable Long id) {
        newsService.delete(id);
    }

    @GetMapping("/check/{id}")
    @ResponseBody
    public void addCheck(@PathVariable Long id) {

        checkService.add(ContentType.NEWS, id);
    }
}
