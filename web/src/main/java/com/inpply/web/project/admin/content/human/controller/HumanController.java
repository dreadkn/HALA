package com.inpply.web.project.admin.content.human.controller;

import com.inpply.common.domain.type.ContentType;
import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.content.check.service.CheckService;
import com.inpply.web.project.admin.content.human.dto.HumanDto;
import com.inpply.web.project.admin.content.human.repository.HumanQueryRepository;
import com.inpply.web.project.admin.content.human.service.HumanService;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.validation.Valid;

@Controller
@RequestMapping("/admin/human")
@Slf4j
@RequiredArgsConstructor
public class HumanController {

    private final HumanQueryRepository humanQueryRepository;

    private final HumanService humanService;
    private final CheckService checkService;

    @GetMapping
    public String viewList(@PageableDefault Pageable pageable, Search search, Model model) {
        return "admin/human/human-list";
    }

    @GetMapping(value = "/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public DataTable.Returned<HumanDto.ListItem> getList(DataTable.Sent sent, Search search) {
        log.debug("DataTables: {}", sent);
        log.debug("Search: {}", search);

        Page<HumanDto.ListItem> page = humanQueryRepository.findAll(sent.getPageable(), search);

        return new DataTable.Returned<>(sent, page);
    }

    @GetMapping({"/form", "/{id}"})
    public String viewForm(@PathVariable(required = false) Long id, Model model) {

        model.addAttribute("id", id);

        return "admin/human/human-form";
    }

    @GetMapping(value = "/detail/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public HumanDto get(@PathVariable Long id) {
        return humanService.getDto(id);
    }

    @PostMapping
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Long save(@RequestBody @Valid HumanDto humanDto) {

        return humanService.save(humanDto);
    }

    @PutMapping("/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.NO_CONTENT)
    public Long update(@PathVariable Long id, @RequestBody @Valid HumanDto humanDto) {

        return humanService.update(id, humanDto);
    }

    @DeleteMapping("/{id}")
    @ResponseBody
    public void delete(@PathVariable Long id) {
        humanService.delete(id);
    }

    @PostMapping ("/upload/excel")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Boolean uploadExcel(MultipartHttpServletRequest request) {

        humanService.uploadExcel(request);

        return true;
    }

    @GetMapping("/check/{id}")
    @ResponseBody
    public void addCheck(@PathVariable Long id) {

        checkService.add(ContentType.HUMAN, id);
    }
}
