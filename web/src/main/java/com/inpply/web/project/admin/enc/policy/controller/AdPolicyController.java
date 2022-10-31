package com.inpply.web.project.admin.enc.policy.controller;

import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.enc.policy.dto.AdPolicyDto;
import com.inpply.web.project.admin.enc.policy.dto.PolicyDto;
import com.inpply.web.project.admin.enc.policy.repository.AdPolicyQueryRepository;
import com.inpply.web.project.admin.enc.policy.repository.PolicyQueryRepository;
import com.inpply.web.project.admin.enc.policy.service.AdPolicyService;
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
@RequestMapping("/admin/ad-policy")
@Slf4j
@RequiredArgsConstructor
public class AdPolicyController {

    private final AdPolicyQueryRepository adPolicyQueryRepository;

    private final AdPolicyService adPolicyService;

    @GetMapping
    public String viewList(@PageableDefault Pageable pageable, Search search, Model model) {
        return "admin/ad-policy/ad-policy-list";
    }

    @GetMapping(value = "/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public DataTable.Returned<AdPolicyDto.ListItem> getList(DataTable.Sent sent, Search search) {
        log.debug("DataTables: {}", sent);
        log.debug("Search: {}", search);

        Page<AdPolicyDto.ListItem> page = adPolicyQueryRepository.findAll(sent.getPageable(), search);

        return new DataTable.Returned<>(sent, page);
    }

    @GetMapping({"/form", "/{id}"})
    public String viewForm(@PathVariable(required = false) Long id, Model model) {

        model.addAttribute("id", id);

        return "admin/ad-policy/ad-policy-form";
    }

    @GetMapping(value = "/detail/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public AdPolicyDto get(@PathVariable Long id) {
        return adPolicyService.getDto(id);
    }

    @PostMapping
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Long save(@RequestBody @Valid AdPolicyDto adPolicyDto) {

        return adPolicyService.save(adPolicyDto);
    }

    @PutMapping("/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.NO_CONTENT)
    public Long update(@PathVariable Long id, @RequestBody @Valid AdPolicyDto adPolicyDto) {

        return adPolicyService.update(id, adPolicyDto);
    }

    @DeleteMapping("/{id}")
    @ResponseBody
    public void delete(@PathVariable Long id) {
        adPolicyService.delete(id);
    }
}
