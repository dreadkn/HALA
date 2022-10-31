package com.inpply.web.project.admin.content.event.controller;

import com.inpply.common.domain.type.ContentType;
import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.content.check.service.CheckService;
import com.inpply.web.project.admin.content.event.dto.EventDto;
import com.inpply.web.project.admin.content.event.repository.EventQueryRepository;
import com.inpply.web.project.admin.content.event.service.EventService;
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
@RequestMapping("/admin/event")
@Slf4j
@RequiredArgsConstructor
public class EventController {

    private final EventQueryRepository eventQueryRepository;

    private final EventService eventService;
    private final CheckService checkService;

    @GetMapping
    public String viewList(@PageableDefault Pageable pageable, Search search, Model model) {
        return "admin/event/event-list";
    }

    @GetMapping(value = "/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public DataTable.Returned<EventDto.ListItem> getList(DataTable.Sent sent, Search search) {
        log.debug("DataTables: {}", sent);
        log.debug("Search: {}", search);

        Page<EventDto.ListItem> page = eventQueryRepository.findAll(sent.getPageable(), search);

        return new DataTable.Returned<>(sent, page);
    }

    @GetMapping({"/form", "/{id}"})
    public String viewForm(@PathVariable(required = false) Long id, Model model) {

        model.addAttribute("id", id);

        return "admin/event/event-form";
    }

    @GetMapping(value = "/detail/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public EventDto get(@PathVariable Long id) {
        return eventService.getDto(id);
    }

    @PostMapping
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Long save(@RequestBody @Valid EventDto eventDto) {

        return eventService.save(eventDto);
    }

    @PutMapping("/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.NO_CONTENT)
    public Long update(@PathVariable Long id, @RequestBody @Valid EventDto eventDto) {

        return eventService.update(id, eventDto);
    }

    @DeleteMapping("/{id}")
    @ResponseBody
    public void delete(@PathVariable Long id) {
        eventService.delete(id);
    }

    @GetMapping("/check/{id}")
    @ResponseBody
    public void addCheck(@PathVariable Long id) {

        checkService.add(ContentType.EVENT, id);
    }
}
