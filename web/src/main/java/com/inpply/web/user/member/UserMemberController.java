package com.inpply.web.user.member;

import com.inpply.common.domain.type.PaymentStatus;
import com.inpply.common.domain.type.PaymentType;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import com.inpply.web.global.validator.OnCreate;
import com.inpply.web.global.validator.OnUpdate;
import com.inpply.web.project.admin.content.check.dto.CheckDto;
import com.inpply.web.project.admin.content.check.repository.CheckQueryRepository;
import com.inpply.web.project.admin.enc.policy.dto.SubscribePolicyDto;
import com.inpply.web.project.admin.enc.policy.repository.SubscribePolicyQueryRepository;
import com.inpply.web.project.admin.enc.policy.service.SubscribePolicyService;
import com.inpply.web.project.admin.member.normal.dto.MemberDto;
import com.inpply.web.project.admin.member.service.MemberService;
import com.inpply.web.project.admin.subscribe.dto.SubscribeDto;
import com.inpply.web.project.admin.subscribe.repository.SubscribeQueryRepository;
import com.inpply.web.project.admin.subscribe.service.SubscribeService;
import com.inpply.web.security.AuthenticationHelper;
import com.inpply.web.user.member.dto.FindDto;
import com.inpply.web.user.member.service.UserFindService;
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

import javax.validation.Valid;
import javax.validation.groups.Default;
import java.util.Optional;

@Controller
@RequestMapping("/member")
@RequiredArgsConstructor
@Slf4j
public class UserMemberController {

    private final MemberService memberService;
    private final UserFindService userFindService;
    private final SubscribePolicyQueryRepository subscribePolicyQueryRepository;

    private final SubscribeQueryRepository subscribeQueryRepository;
    private final SubscribeService subscribeService;

    private final CheckQueryRepository checkQueryRepository;


    @GetMapping(value="signup")
    public String signup(Model model) {
        return "/user/member/signup";
    }

    @GetMapping(value="login")
    public String login(Model model) {

        if (AuthenticationHelper.isAuthenticated())
            return "redirect:/";

        return "/user/member/login";
    }

    @GetMapping(value={"find/id"})
    public String getFindId(Model model, @PathVariable (required = false) String type) {

        return "/user/member/find-id";
    }

    @PostMapping("/find/id")
    @ResponseBody
    public FindDto.Response findId(@RequestBody @Valid FindDto.Request request) {
        log.debug("User Find Id Request : {}", request);
        return userFindService.findId(request);
    }

    @GetMapping(value={"find/pw"})
    public String findPw(Model model, @PathVariable (required = false) String type) {
        model.addAttribute("type", type);
        return "/user/member/find-pw";
    }


    @PostMapping("/signup")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Long save(@RequestBody @Validated({Default.class, OnCreate.class}) MemberDto memberDto) {

        return memberService.save(memberDto);
    }

    @GetMapping(value="mypage")
    public String mypage(Model model) {
        return "/user/member/mypage";
    }

    @GetMapping(value = "/info", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public MemberDto getMemberInfo() {
        return memberService.getDto(AuthenticationHelper.getId().orElseGet(() -> -1l));
    }

    @GetMapping(value = "/subscribe/policy", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public SubscribePolicyDto getSubscribePolicy() {
        SubscribePolicyDto subscribePolicyDto =  subscribePolicyQueryRepository.findByToday()
                .orElseGet(() -> new SubscribePolicyDto());
        return subscribePolicyDto;
    }

    @GetMapping(value = "/subscribe", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public SubscribeDto.MemberSubscribeDto getSubscribe() {
        SubscribeDto.MemberSubscribeDto subscribeDto =  subscribeQueryRepository.findByMember(AuthenticationHelper.getId().orElseGet(() -> -1l))
                .orElseGet(() -> new SubscribeDto.MemberSubscribeDto());
        return subscribeDto;
    }

    @PostMapping("/subscribe")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Long subscribe(@RequestBody @Valid SubscribeDto.Request subscribeDto) {

        return subscribeService.subscribe(subscribeDto);
    }

    @PostMapping("/unsubscribe")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public void unsubscribe() {

        subscribeService.unsubscribe();
    }

    @PutMapping("/update")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.NO_CONTENT)
    public Long update(@RequestBody @Validated({Default.class, OnUpdate.class}) MemberDto.UserRequest memberDto) {

        return memberService.update(AuthenticationHelper.getId().orElseGet(() -> -1l), memberDto);
    }

    @GetMapping(value = "/content/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Page<CheckDto.ListItem> getContentList(@PageableDefault Pageable pageable) {

        Page<CheckDto.ListItem> page = checkQueryRepository.findAllByMember(pageable, AuthenticationHelper.getId().orElseGet(() -> -1l));

        return page;
    }
}
