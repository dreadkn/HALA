package com.inpply.web.user.familyEvent.controller;

import com.inpply.common.domain.entity.ContentPolicy;
import com.inpply.common.domain.repository.ContentPolicyRepository;
import com.inpply.common.domain.type.ContentType;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.content.check.service.CheckService;
import com.inpply.web.project.admin.content.event.dto.EventDto;
import com.inpply.web.project.admin.content.news.dto.NewsDto;
import com.inpply.web.project.admin.content.wedding.dto.WeddingDto;
import com.inpply.web.project.admin.content.wedding.repository.WeddingQueryRepository;
import com.inpply.web.project.admin.content.wedding.service.WeddingService;
import com.inpply.web.project.admin.enc.policy.dto.ContentPolicyDto;
import com.inpply.web.security.AuthenticationHelper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/familyEvent")
@RequiredArgsConstructor
@Slf4j
public class UserFamilyEventController {

    private final WeddingQueryRepository weddingQueryRepository;
    private final WeddingService weddingService;

    private final CheckService checkService;

    private final ContentPolicyRepository contentPolicyRepository;
    private final ModelMapper modelMapper;

    @GetMapping(value={"", "/{type}"})
    public String list(Model model, @PathVariable(required = false) String type) {
        model.addAttribute("type", type);
        return "/user/familyEvent/familyEvent-list";
    }

    @GetMapping(value = "/wedding/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Page<WeddingDto> getListByWedding(@PageableDefault Pageable pageable, Search search) {
        log.debug("Search: {}", search);

        Page<WeddingDto> page = weddingQueryRepository.findAllByWedding(pageable, search);

        return page;
    }

    @GetMapping(value = "/death/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Page<WeddingDto> getListByDeath(@PageableDefault Pageable pageable, Search search) {
        log.debug("Search: {}", search);

        Page<WeddingDto> page = weddingQueryRepository.findAllByDeath(pageable, search);

        return page;
    }

    @GetMapping(value = "/person/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Page<WeddingDto> getListByPerson(@PageableDefault Pageable pageable, Search search) {
        log.debug("Search: {}", search);

        Page<WeddingDto> page = weddingQueryRepository.findAllByPerson(pageable, search);

        return page;
    }
    @GetMapping(value = "form")
    public String home(Model model) {

        if (!AuthenticationHelper.isAuthenticated())
            return "redirect:/member/login";

        return "/user/familyEvent/familyEvent-form";
    }
    @GetMapping(value = "detail")
    public String detail(Model model) {
        return "/user/familyEvent/familyEvent-detail";
    }

    @GetMapping(value = "wedding/{id}")
    public String weddingDetail(Model model, @PathVariable Long id) {
        model.addAttribute("id", id);
        return "/user/familyEvent/familyEvent-wedding-detail";
    }

    @GetMapping(value = "/detail/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public WeddingDto getWedding(@PathVariable Long id) {
        return weddingService.getDto(id);
    }

    @GetMapping(value = "obituary/{id}")
    public String obituaryDetail(Model model, @PathVariable Long id) {
        model.addAttribute("id", id);
        return "/user/familyEvent/familyEvent-obituary-detail";
    }

    @GetMapping(value = "personnel/{id}")
    public String peopleDictionaryDetail(Model model, @PathVariable Long id) {
        model.addAttribute("id", id);
        return "/user/familyEvent/familyEvent-personnel-detail";
    }

    @PostMapping
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Long submit(@RequestBody @Valid WeddingDto weddingDto) {

        Long id =  weddingService.save(weddingDto);
        checkService.add(ContentType.CONGRATULATIONS, id);

        return id;
    }

    @GetMapping(value = "/price")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public ContentPolicyDto getPrice() {

        ContentPolicyDto contentPolicyDto = new ContentPolicyDto();

        LocalDateTime today = LocalDateTime.now();
        List<ContentPolicy> contentPolicies = contentPolicyRepository.findByContentTypeAndStartDateBeforeAndEndDateAfterOrderByStartDateDesc(ContentType.CONGRATULATIONS, today, today);
        if (contentPolicies.size() > 0)
            contentPolicyDto = modelMapper.map(contentPolicies.get(0), ContentPolicyDto.class);

        return contentPolicyDto;
    }

}
