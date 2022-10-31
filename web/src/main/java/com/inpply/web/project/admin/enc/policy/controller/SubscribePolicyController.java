package com.inpply.web.project.admin.enc.policy.controller;

import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.enc.policy.dto.PolicyDto;
import com.inpply.web.project.admin.enc.policy.dto.SubscribePolicyDto;
import com.inpply.web.project.admin.enc.policy.repository.PolicyQueryRepository;
import com.inpply.web.project.admin.enc.policy.repository.SubscribePolicyQueryRepository;
import com.inpply.web.project.admin.enc.policy.service.PolicyService;
import com.inpply.web.project.admin.enc.policy.service.SubscribePolicyService;
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
@RequestMapping("/admin/subscribe-policy")
@Slf4j
@RequiredArgsConstructor
public class SubscribePolicyController {

    private final SubscribePolicyQueryRepository subscribePolicyQueryRepository;

    private final SubscribePolicyService subscribePolicyService;

    @GetMapping
    public String viewList(@PageableDefault Pageable pageable, Search search, Model model) {
        return "admin/subscribe-policy/subscribe-policy-list";
    }

    @GetMapping(value = "/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public DataTable.Returned<SubscribePolicyDto.ListItem> getList(DataTable.Sent sent, Search search) {
        log.debug("DataTables: {}", sent);
        log.debug("Search: {}", search);

        Page<SubscribePolicyDto.ListItem> page = subscribePolicyQueryRepository.findAll(sent.getPageable(), search);

        return new DataTable.Returned<>(sent, page);
    }

    @GetMapping({"/form", "/{id}"})
    public String viewForm(@PathVariable(required = false) Long id, Model model) {

        model.addAttribute("id", id);

        return "admin/subscribe-policy/subscribe-policy-form";
    }

    @GetMapping(value = "/detail/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public SubscribePolicyDto get(@PathVariable Long id) {
        return subscribePolicyService.getDto(id);
    }

    @PostMapping
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Long save(@RequestBody @Valid SubscribePolicyDto subscribePolicyDto) {

        return subscribePolicyService.save(subscribePolicyDto);
    }

    @PutMapping("/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.NO_CONTENT)
    public Long update(@PathVariable Long id, @RequestBody @Valid SubscribePolicyDto subscribePolicyDto) {

        return subscribePolicyService.update(id, subscribePolicyDto);
    }

    @DeleteMapping("/{id}")
    @ResponseBody
    public void delete(@PathVariable Long id) {
        subscribePolicyService.delete(id);
    }
}
