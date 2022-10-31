package com.inpply.web.project.admin.complaint.controller;

import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.complaint.dto.ComplaintDto;
import com.inpply.web.project.admin.complaint.repository.ComplaintQueryRepository;
import com.inpply.web.project.admin.complaint.service.ComplaintService;
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
@RequestMapping("/admin/complaint")
@Slf4j
@RequiredArgsConstructor
public class ComplaintController {

    private final ComplaintQueryRepository complaintQueryRepository;

    private final ComplaintService complaintService;

    @GetMapping
    public String viewList(@PageableDefault Pageable pageable, Search search, Model model) {
        return "admin/complaint/complaint-list";
    }

    @GetMapping(value = "/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public DataTable.Returned<ComplaintDto.ListItem> getList(DataTable.Sent sent, Search search) {
        log.debug("DataTables: {}", sent);
        log.debug("Search: {}", search);

        Page<ComplaintDto.ListItem> page = complaintQueryRepository.findAll(sent.getPageable(), search);

        return new DataTable.Returned<>(sent, page);
    }

    @GetMapping({"/form", "/{id}"})
    public String viewForm(@PathVariable(required = false) Long id, Model model) {

        model.addAttribute("id", id);

        return "admin/complaint/complaint-form";
    }

    @GetMapping(value = "/detail/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public ComplaintDto get(@PathVariable Long id) {
        return complaintService.getDto(id);
    }

    @PostMapping
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Long save(@RequestBody @Valid ComplaintDto complaintDto) {

        return complaintService.save(complaintDto);
    }

    @PutMapping("/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.NO_CONTENT)
    public Long update(@PathVariable Long id, @RequestBody @Valid ComplaintDto complaintDto) {

        return complaintService.update(id, complaintDto);
    }

    @PutMapping("/answer/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.NO_CONTENT)
    public Long answer(@PathVariable Long id, @RequestBody @Valid ComplaintDto complaintDto) {

        return complaintService.answer(id, complaintDto);
    }

    @DeleteMapping("/{id}")
    @ResponseBody
    public void delete(@PathVariable Long id) {
        complaintService.delete(id);
    }
}
