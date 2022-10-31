package com.inpply.web.user.community.controller;

import com.inpply.web.project.admin.ad.dto.AdDto;
import com.inpply.web.project.admin.ad.service.AdService;
import com.inpply.web.project.admin.complaint.dto.ComplaintDto;
import com.inpply.web.project.admin.complaint.service.ComplaintService;
import com.inpply.web.security.AuthenticationHelper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@Controller
@RequestMapping("community")
@RequiredArgsConstructor
@Slf4j
public class UserCommunityController {

    private final ComplaintService complaintService;
    private final AdService adService;

    @GetMapping(value = "about")
    public String about(Model model) {
        return "/user/community/about";
    }
    @GetMapping(value = "report")
    public String report(Model model) {
        return "/user/community/report-form";
    }

    @PostMapping("/report/submit")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Long submitReport(@RequestBody @Valid ComplaintDto complaintDto) {

        return complaintService.save(complaintDto);
    }
    @GetMapping(value = "question")
    public String question(Model model) {

        if (!AuthenticationHelper.isAuthenticated())
            return "redirect:/member/login";

        return "/user/community/question-form";
    }

    @PostMapping("/question/submit")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Long submitQuestion(@RequestBody @Valid AdDto.PeriodRequest adDto) {

        return adService.save(adDto);
    }
}
