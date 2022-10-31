package com.inpply.web.project.admin.enc.policy.controller;

import com.inpply.common.domain.entity.Policy;
import com.inpply.common.domain.repository.PolicyRepository;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.enc.policy.dto.PolicyDto;
import com.inpply.web.project.admin.enc.policy.repository.PolicyQueryRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Optional;

@Controller
@RequestMapping("/admin/policy")
@Slf4j
@RequiredArgsConstructor
public class PolicyController {

    private final PolicyRepository policyRepository;
    private final PolicyQueryRepository policyQueryRepository;
    private final ModelMapper modelMapper;

    @GetMapping
    public String viewList(@PageableDefault Pageable pageable, Search search, Model model) {
        return "admin/policy/policy-list";
    }

    @GetMapping(value = "/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public DataTable.Returned<PolicyDto.ListItem> getList(DataTable.Sent sent, Search search) {
        log.debug("DataTables: {}", sent);
        log.debug("Search: {}", search);

        Page<PolicyDto.ListItem> page = policyQueryRepository.findAll(sent.getPageable(), search);

        return new DataTable.Returned<>(sent, page);
    }

    @GetMapping({"/form", "/{id}"})
    public String viewForm(@PathVariable(required = false) Long id, Model model) {

        model.addAttribute("item", policyRepository.findById(Optional.ofNullable(id).orElse(-1l)).orElse(Policy.builder().build()));

        return "admin/policy/policy-form";
    }

    @GetMapping(value = "/detail/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Policy get(@PathVariable Long id) {
        Policy policy = policyRepository.findById(id)
            .orElseThrow(() -> new EntityNotFoundException("policy", "policyId", id));

        return policy;
    }

    @PostMapping
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Long save(@RequestBody @Valid PolicyDto policyDto) {

        Policy result = policyRepository.save(modelMapper.map(policyDto, Policy.class));

        return result.getId();
    }

    @PutMapping("/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.NO_CONTENT)
    public Long update(@PathVariable Long id, @RequestBody @Valid PolicyDto policyDto) {

        policyDto.setId(id);

        Policy result = policyRepository.save(modelMapper.map(policyDto, Policy.class));
        return result.getId();
    }

    @DeleteMapping("/{id}")
    @ResponseBody
    public void delete(@PathVariable Long id) {
        policyRepository.deleteById(id);
    }
}
