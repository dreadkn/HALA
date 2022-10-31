package com.inpply.web.project.admin.member.normal.controller;

import com.inpply.common.domain.user.model.User;
import com.inpply.web.common.user.repository.UserRepository;
import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import com.inpply.web.global.validator.OnCreate;
import com.inpply.web.global.validator.OnUpdate;
import com.inpply.web.project.admin.member.normal.dto.MemberDto;
import com.inpply.web.project.admin.member.normal.repository.MemberQueryRepository;
import com.inpply.web.project.admin.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.groups.Default;

@Controller
@RequestMapping("/admin/member")
@Slf4j
@RequiredArgsConstructor
public class MemberController {

    private final MemberQueryRepository memberQueryRepository;

    private final MemberService memberService;
    private final UserRepository userRepository;

    @GetMapping
    public String viewList(@PageableDefault Pageable pageable, Search search, Model model) {
        return "admin/member/member-list";
    }

    @GetMapping(value = "/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public DataTable.Returned<MemberDto.ListItem> getList(DataTable.Sent sent, Search search) {
        log.debug("DataTables: {}", sent);
        log.debug("Search: {}", search);

        Page<MemberDto.ListItem> page = memberQueryRepository.findAll(sent.getPageable(), search);

        return new DataTable.Returned<>(sent, page);
    }

    @GetMapping({"/form", "/{id}"})
    public String viewForm(@PathVariable(required = false) Long id, Model model) {

        model.addAttribute("id", id);

        return "admin/member/member-form";
    }

    @GetMapping(value = "/detail/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public MemberDto get(@PathVariable Long id) {
        return memberService.getDto(id);
    }

    @PostMapping
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Long save(@RequestBody @Validated({Default.class, OnCreate.class}) MemberDto memberDto) {

        return memberService.save(memberDto);
    }

    @PutMapping("/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.NO_CONTENT)
    public Long update(@PathVariable Long id, @RequestBody @Validated({Default.class, OnUpdate.class}) MemberDto memberDto) {

        return memberService.update(id, memberDto);
    }

    @DeleteMapping("/{id}")
    @ResponseBody
    public void delete(@PathVariable Long id) {
        memberService.delete(id);
    }

    @PostMapping(value = "/check/overlap/{userId}", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public boolean checkOverlap(@PathVariable String userId) {
        User result = userRepository.findByUserId(userId).orElse(null);
        return result == null ? false : true;
    }

    @PostMapping(value = "/block/{id}", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public void block(@PathVariable Long id) {
        memberService.block(id);
    }
}
