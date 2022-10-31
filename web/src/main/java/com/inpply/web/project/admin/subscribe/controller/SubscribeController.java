package com.inpply.web.project.admin.subscribe.controller;

import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.subscribe.repository.SubscribeQueryRepository;
import com.inpply.web.project.admin.subscribe.dto.SubscribeDto;
import com.inpply.web.project.admin.subscribe.service.SubscribeService;
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
@RequestMapping("/admin/subscribe")
@Slf4j
@RequiredArgsConstructor
public class SubscribeController {

    private final SubscribeQueryRepository subscribeQueryRepository;

    private final SubscribeService subscribeService;

    @GetMapping
    public String viewList(@PageableDefault Pageable pageable, Search search, Model model) {
        return "admin/subscribe/subscribe-list";
    }

    @GetMapping(value = "/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public DataTable.Returned<SubscribeDto.ListItem> getList(DataTable.Sent sent, Search search) {
        log.debug("DataTables: {}", sent);
        log.debug("Search: {}", search);

        Page<SubscribeDto.ListItem> page = subscribeQueryRepository.findAll(sent.getPageable(), search);

        return new DataTable.Returned<>(sent, page);
    }

    @GetMapping({"/form", "/{id}"})
    public String viewForm(@PathVariable(required = false) Long id, Model model) {

        model.addAttribute("id", id);

        return "admin/subscribe/subscribe-form";
    }

    @GetMapping(value = "/detail/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public SubscribeDto get(@PathVariable Long id) {
        return subscribeService.getDto(id);
    }

    @PostMapping
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Long subscribe(@RequestBody @Valid SubscribeDto.Request subscribeDto) {

        return subscribeService.subscribe(subscribeDto);
    }

    @PutMapping("/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.NO_CONTENT)
    public Long update(@PathVariable Long id, @RequestBody @Valid SubscribeDto.Request subscribeDto) {

        return subscribeService.update(id, subscribeDto);
    }

    @DeleteMapping("/{id}")
    @ResponseBody
    public void delete(@PathVariable Long id) {
        subscribeService.delete(id);
    }
}
