package com.inpply.web.project.admin.enc.policy.controller;

import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.enc.policy.dto.ContentPolicyDto;
import com.inpply.web.project.admin.enc.policy.dto.PolicyDto;
import com.inpply.web.project.admin.enc.policy.repository.ContentPolicyQueryRepository;
import com.inpply.web.project.admin.enc.policy.repository.PolicyQueryRepository;
import com.inpply.web.project.admin.enc.policy.service.ContentPolicyService;
import com.inpply.web.project.admin.enc.policy.service.PolicyService;
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
@RequestMapping("/admin/content-policy")
@Slf4j
@RequiredArgsConstructor
public class ContentPolicyController {

    private final ContentPolicyQueryRepository contentPolicyQueryRepository;

    private final ContentPolicyService contentPolicyService;

    @GetMapping
    public String viewList(@PageableDefault Pageable pageable, Search search, Model model) {
        return "admin/content-policy/content-policy-list";
    }

    @GetMapping(value = "/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public DataTable.Returned<ContentPolicyDto.ListItem> getList(DataTable.Sent sent, Search search) {
        log.debug("DataTables: {}", sent);
        log.debug("Search: {}", search);

        Page<ContentPolicyDto.ListItem> page = contentPolicyQueryRepository.findAll(sent.getPageable(), search);

        return new DataTable.Returned<>(sent, page);
    }

    @GetMapping({"/form", "/{id}"})
    public String viewForm(@PathVariable(required = false) Long id, Model model) {

        model.addAttribute("id", id);

        return "admin/content-policy/content-policy-form";
    }

    @GetMapping(value = "/detail/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public ContentPolicyDto get(@PathVariable Long id) {
        return contentPolicyService.getDto(id);
    }

    @PostMapping
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Long save(@RequestBody @Valid ContentPolicyDto contentPolicyDto) {

        return contentPolicyService.save(contentPolicyDto);
    }

    @PutMapping("/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.NO_CONTENT)
    public Long update(@PathVariable Long id, @RequestBody @Valid ContentPolicyDto contentPolicyDto) {

        return contentPolicyService.update(id, contentPolicyDto);
    }

    @DeleteMapping("/{id}")
    @ResponseBody
    public void delete(@PathVariable Long id) {
        contentPolicyService.delete(id);
    }
}
