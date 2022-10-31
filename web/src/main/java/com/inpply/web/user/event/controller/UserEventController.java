package com.inpply.web.user.event.controller;

import com.inpply.common.domain.entity.ContentPolicy;
import com.inpply.common.domain.repository.ContentPolicyRepository;
import com.inpply.common.domain.type.ContentType;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.content.check.service.CheckService;
import com.inpply.web.project.admin.content.event.dto.EventDto;
import com.inpply.web.project.admin.content.event.repository.EventQueryRepository;
import com.inpply.web.project.admin.content.event.service.EventService;
import com.inpply.web.project.admin.content.news.dto.NewsDto;
import com.inpply.web.project.admin.content.news.repository.NewsQueryRepository;
import com.inpply.web.project.admin.content.news.service.NewsService;
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
@RequestMapping("/event")
@RequiredArgsConstructor
@Slf4j
public class UserEventController {

    private final EventQueryRepository eventQueryRepository;
    private final EventService eventService;
    private final CheckService checkService;

    private final ContentPolicyRepository contentPolicyRepository;
    private final ModelMapper modelMapper;
    @GetMapping
    public String list(Model model) {
        return "/user/event/event-list";
    }

    @GetMapping(value = "/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Page<EventDto.ListItem> getList(@PageableDefault(direction = Sort.Direction.DESC, sort = "createdDate") Pageable pageable, Search search) {
        log.debug("Search: {}", search);

        Page<EventDto.ListItem> page = eventQueryRepository.findAllByPublic(pageable, search);

        return page;
    }
    @GetMapping(value = "form")
    public String home(Model model) {

        if (!AuthenticationHelper.isAuthenticated())
            return "redirect:/member/login";

        return "/user/event/event-form";
    }
    @GetMapping(value = "/{id}")
    public String detail(Model model, @PathVariable Long id) {
        model.addAttribute("id", id);
        return "/user/event/event-detail";
    }

    @GetMapping(value = "/detail/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public EventDto get(@PathVariable Long id) {
        return eventQueryRepository.findById(id);
    }

    @PostMapping
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Long submit(@RequestBody @Valid EventDto eventDto) {

        Long id =  eventService.save(eventDto);
        checkService.add(ContentType.NEWS, id);

        return id;
    }

    @GetMapping(value = "/price")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public ContentPolicyDto getPrice() {

        ContentPolicyDto contentPolicyDto = new ContentPolicyDto();

        LocalDateTime today = LocalDateTime.now();
        List<ContentPolicy> contentPolicies = contentPolicyRepository.findByContentTypeAndStartDateBeforeAndEndDateAfterOrderByStartDateDesc(ContentType.EVENT, today, today);
        if (contentPolicies.size() > 0)
            contentPolicyDto = modelMapper.map(contentPolicies.get(0), ContentPolicyDto.class);
        return contentPolicyDto;
    }
}
