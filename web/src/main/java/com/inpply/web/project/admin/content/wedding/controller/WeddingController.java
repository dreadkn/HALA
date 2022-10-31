package com.inpply.web.project.admin.content.wedding.controller;

import com.inpply.common.domain.type.ContentType;
import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.content.check.service.CheckService;
import com.inpply.web.project.admin.content.wedding.dto.WeddingDto;
import com.inpply.web.project.admin.content.wedding.repository.WeddingQueryRepository;
import com.inpply.web.project.admin.content.wedding.service.WeddingService;
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
@RequestMapping("/admin/wedding")
@Slf4j
@RequiredArgsConstructor
public class WeddingController {

    private final WeddingQueryRepository weddingQueryRepository;

    private final WeddingService weddingService;
    private final CheckService checkService;

    @GetMapping
    public String viewList(@PageableDefault Pageable pageable, Search search, Model model) {
        return "admin/wedding/wedding-list";
    }

    @GetMapping(value = "/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public DataTable.Returned<WeddingDto.ListItem> getList(DataTable.Sent sent, Search search) {
        log.debug("DataTables: {}", sent);
        log.debug("Search: {}", search);

        Page<WeddingDto.ListItem> page = weddingQueryRepository.findAll(sent.getPageable(), search);

        return new DataTable.Returned<>(sent, page);
    }

    @GetMapping({"/form", "/{id}"})
    public String viewForm(@PathVariable(required = false) Long id, Model model) {

        model.addAttribute("id", id);

        return "admin/wedding/wedding-form";
    }

    @GetMapping(value = "/detail/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public WeddingDto get(@PathVariable Long id) {
        return weddingService.getDto(id);
    }

    @PostMapping
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Long save(@RequestBody @Valid WeddingDto weddingDto) {

        return weddingService.save(weddingDto);
    }

    @PutMapping("/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.NO_CONTENT)
    public Long update(@PathVariable Long id, @RequestBody @Valid WeddingDto weddingDto) {

        return weddingService.update(id, weddingDto);
    }

    @DeleteMapping("/{id}")
    @ResponseBody
    public void delete(@PathVariable Long id) {
        weddingService.delete(id);
    }

    @GetMapping("/check/{id}")
    @ResponseBody
    public void addCheck(@PathVariable Long id) {

        checkService.add(ContentType.CONGRATULATIONS, id);
    }
}
