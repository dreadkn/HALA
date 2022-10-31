package com.inpply.web.project.admin.member.block.controller;

import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.member.block.repository.BlockMemberQueryRepository;
import com.inpply.web.project.admin.member.normal.dto.MemberDto;
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
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/member-block")
@Slf4j
@RequiredArgsConstructor
public class BlockMemberController {

    private final BlockMemberQueryRepository blockMemberQueryRepository;

    private final MemberService memberService;

    @GetMapping
    public String viewList(@PageableDefault Pageable pageable, Search search, Model model) {
        return "admin/member-block/member-block-list";
    }

    @GetMapping(value = "/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public DataTable.Returned<MemberDto.ListItem> getList(DataTable.Sent sent, Search search) {
        log.debug("DataTables: {}", sent);
        log.debug("Search: {}", search);

        Page<MemberDto.ListItem> page = blockMemberQueryRepository.findAll(sent.getPageable(), search);

        return new DataTable.Returned<>(sent, page);
    }

    @GetMapping({"/form", "/{id}"})
    public String viewForm(@PathVariable(required = false) Long id, Model model) {

        model.addAttribute("id", id);

        return "admin/member-block/member-block-form";
    }

    @GetMapping(value = "/detail/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public MemberDto get(@PathVariable Long id) {
        return memberService.getDto(id);
    }


    @DeleteMapping("/{id}")
    @ResponseBody
    public void delete(@PathVariable Long id) {
        memberService.delete(id);
    }

    @PostMapping(value = "/unblock/{id}", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public void unblock(@PathVariable Long id) {
        memberService.unblock(id);
    }

}
