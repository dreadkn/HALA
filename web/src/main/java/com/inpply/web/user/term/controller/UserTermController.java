package com.inpply.web.user.term.controller;

import com.inpply.common.domain.entity.Policy;
import com.inpply.common.domain.repository.PolicyRepository;
import com.inpply.common.domain.type.PolicyType;
import com.inpply.web.project.admin.enc.policy.dto.PolicyDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/term")
@RequiredArgsConstructor
@Slf4j
public class UserTermController {

    private final PolicyRepository policyRepository;
    private final ModelMapper modelMapper;

    @GetMapping(value = "/service")
    public String seviceTerm(Model model) {
        return "/user/term/service";
    }
    @GetMapping(value = "/private")
    public String privateTerm(Model model) {
        return "/user/term/private";
    }

    @GetMapping(value={"policy/{policyType}"})
    @ResponseBody
    public PolicyDto getPolicy(Model model, @PathVariable PolicyType policyType) {
        PolicyDto policyDto = new PolicyDto();

        List<Policy> policies = policyRepository.findByPolicyTypeOrderByVersionDesc(policyType);

        if (policies.size() > 0)
            policyDto = modelMapper.map(policies.get(0), PolicyDto.class);

        return policyDto;
    }
}
