package com.inpply.web.user.news.controller;

import com.inpply.common.domain.entity.ContentPolicy;
import com.inpply.common.domain.entity.Policy;
import com.inpply.common.domain.repository.ContentCheckRepository;
import com.inpply.common.domain.repository.ContentPolicyRepository;
import com.inpply.common.domain.repository.PolicyRepository;
import com.inpply.common.domain.type.ContentType;
import com.inpply.common.domain.type.PolicyType;
import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.content.check.service.CheckService;
import com.inpply.web.project.admin.content.news.dto.NewsDto;
import com.inpply.web.project.admin.content.news.repository.NewsQueryRepository;
import com.inpply.web.project.admin.content.news.service.NewsService;
import com.inpply.web.project.admin.enc.policy.dto.ContentPolicyDto;
import com.inpply.web.project.admin.enc.policy.dto.PolicyDto;
import com.inpply.web.project.admin.enc.policy.repository.ContentPolicyQueryRepository;
import com.inpply.web.security.AuthenticationHelper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.tomcat.jni.Local;
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
@RequestMapping("/news")
@RequiredArgsConstructor
@Slf4j
public class UserNewsController {

    private final NewsQueryRepository newsQueryRepository;
    private final NewsService newsService;
    private final CheckService checkService;
    private final ContentPolicyRepository contentPolicyRepository;
    private final ModelMapper modelMapper;

    @GetMapping
    public String list(Model model) {
        return "/user/news/news-list";
    }

    @GetMapping(value = "/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Page<NewsDto.ListItem> getList(@PageableDefault(direction = Sort.Direction.DESC, sort = "createdDate") Pageable pageable, Search search) {
        log.debug("Search: {}", search);

        Page<NewsDto.ListItem> page = newsQueryRepository.findAllByPublic(pageable, search);

        return page;
    }

    @GetMapping(value = "form")
    public String home(Model model) {

        if (!AuthenticationHelper.isAuthenticated())
            return "redirect:/member/login";

        return "/user/news/news-form";
    }
    @GetMapping(value = "/{id}")
    public String detail(Model model, @PathVariable Long id) {

        model.addAttribute("id", id);

        return "/user/news/news-detail";
    }

    @GetMapping(value = "/detail/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public NewsDto get(@PathVariable Long id) {
        return newsQueryRepository.findById(id);
    }

    @PostMapping
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Long submit(@RequestBody @Valid NewsDto newsDto) {

        Long id =  newsService.save(newsDto);
        checkService.add(ContentType.NEWS, id);

        return id;
    }

    @GetMapping(value = "/price")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public ContentPolicyDto getPrice() {

        ContentPolicyDto contentPolicyDto = new ContentPolicyDto();

        LocalDateTime today = LocalDateTime.now();
        List<ContentPolicy> contentPolicies = contentPolicyRepository.findByContentTypeAndStartDateBeforeAndEndDateAfterOrderByStartDateDesc(ContentType.NEWS, today, today);
        if (contentPolicies.size() > 0)
            contentPolicyDto = modelMapper.map(contentPolicies.get(0), ContentPolicyDto.class);
        return contentPolicyDto;
    }


}
