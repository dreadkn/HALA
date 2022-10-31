package com.inpply.web.project.api.search.controller;

import com.inpply.common.domain.entity.Policy;
import com.inpply.common.domain.repository.CongratulationsRepository;
import com.inpply.common.domain.repository.PolicyRepository;
import com.inpply.common.domain.type.AppType;
import com.inpply.common.domain.type.ContentType;
import com.inpply.common.domain.type.PolicyType;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.ad.dto.AdDto;
import com.inpply.web.project.admin.ad.repository.AdQueryRepository;
import com.inpply.web.project.admin.content.event.dto.EventDto;
import com.inpply.web.project.admin.content.event.repository.EventQueryRepository;
import com.inpply.web.project.admin.content.human.dto.HumanDto;
import com.inpply.web.project.admin.content.human.repository.HumanQueryRepository;
import com.inpply.web.project.admin.content.news.dto.NewsDto;
import com.inpply.web.project.admin.content.news.repository.NewsQueryRepository;
import com.inpply.web.project.admin.content.wedding.dto.WeddingDto;
import com.inpply.web.project.admin.content.wedding.repository.WeddingQueryRepository;
import com.inpply.web.project.admin.content.wedding.service.WeddingService;
import com.inpply.web.project.admin.enc.policy.dto.PolicyDto;
import com.inpply.web.project.admin.enc.version.dto.VersionDto;
import com.inpply.web.project.admin.enc.version.repository.VersionQueryRepository;
import com.inpply.web.project.admin.content.dto.ContentDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/api/v1/search")
@Slf4j
@RequiredArgsConstructor
@Transactional
public class SearchApiControllerV1 {

    private final AdQueryRepository adQueryRepository;
    private final NewsQueryRepository newsQueryRepository;
    private final WeddingQueryRepository weddingQueryRepository;
    private final WeddingService weddingService;
    private final EventQueryRepository eventQueryRepository;
    private final HumanQueryRepository humanQueryRepository;
    private final PolicyRepository policyRepository;
    private final VersionQueryRepository versionQueryRepository;


    /**
     * 광고 조회
     */
    @GetMapping(value = "/ad")
    @ResponseBody
    public List<AdDto.ApiListItem> getSearchAd() {

        return adQueryRepository.findAllByActive();
    }

    /**
     * 많이 본 목록 조회
     * todo : change best news
     */
    @GetMapping(value = "/best")
    @ResponseBody
    public Page<NewsDto.ApiListItem> getListByBestNews(@PageableDefault(direction = Sort.Direction.DESC, sort = "createdDate") Pageable pageable, Search search) {

        Page<NewsDto.ApiListItem> page = newsQueryRepository.findAllByApi(pageable, search);

        return page;
    }

    /**
     * 뉴스 목록 조회
     */
    @GetMapping(value = "/news")
    @ResponseBody
    public Page<NewsDto.ApiListItem> getListByNews(@PageableDefault(direction = Sort.Direction.DESC, sort = "createdDate") Pageable pageable, Search search) {

        Page<NewsDto.ApiListItem> page = newsQueryRepository.findAllByApi(pageable, search);

        return page;
    }

    /**
     * 뉴스 상세 조회
     */
    @GetMapping(value = "/news/detail")
    @ResponseBody
    public NewsDto.ApiItem getNews(Long id) {

        NewsDto.ApiItem item = newsQueryRepository.findByIdForApi(id);

        return item;
    }

    /**
     * 경조사 목록 조회
     */
    @GetMapping(value = "/congratulations")
    @ResponseBody
    public Page<WeddingDto> getListByCongratulations(@PageableDefault Pageable pageable, Search search) {

        Page<WeddingDto> page = null;

        switch (search.getCongratulationsType())
        {
            case WEDDING:
                page = weddingQueryRepository.findAllByWedding(pageable, search);
                break;
            case DEATH:
                page = weddingQueryRepository.findAllByDeath(pageable, search);
                break;
            case PERSON:
                page = weddingQueryRepository.findAllByPerson(pageable, search);
                break;
        }

        return page;
    }

    /**
     * 경조사 상세 조회
     */
    @GetMapping(value = "/congratulations/detail")
    @ResponseBody
    public WeddingDto getCongratulations(Long id) {

        return weddingService.getDto(id);
    }

    /**
     * 행사 목록 조회
     */
    @GetMapping(value = "/event")
    @ResponseBody
    public Page<EventDto.ApiListItem> getListByEvent(@PageableDefault(direction = Sort.Direction.DESC, sort = "createdDate") Pageable pageable, Search search) {

        Page<EventDto.ApiListItem> page = eventQueryRepository.findAllByApi(pageable, search);

        return page;
    }

    /**
     * 행사 상세 조회
     */
    @GetMapping(value = "/event/detail")
    @ResponseBody
    public EventDto.ApiItem getEvent(Long id) {

        return eventQueryRepository.findByIdForApi(id);
    }

    /**
     * 인명 목록 조회
     */
    @GetMapping(value = "/human")
    @ResponseBody
    public Page<HumanDto.ApiListItem> getListByHuman(@PageableDefault(direction = Sort.Direction.DESC, sort = "createdDate") Pageable pageable, Search search) {

        Page<HumanDto.ApiListItem> page = humanQueryRepository.findAllByApi(pageable, search);

        return page;
    }

    /**
     * 인명 상세 조회
     */
    @GetMapping(value = "/human/detail")
    @ResponseBody
    public HumanDto.ApiItem getHuman(Long id) {

        return humanQueryRepository.findByIdForApi(id);
    }

    /**
     * 회원가입 약관 목록 조회
     */
    @GetMapping(value = "/terms/signup")
    @ResponseBody
    public List<PolicyDto.ApiListItem> getTermSignUp(Long id) {

        List<PolicyDto.ApiListItem> list = new ArrayList<>();

        List<Policy> policies = policyRepository.findByPolicyTypeOrderByVersionDesc(PolicyType.POLICY_USE);

        if (policies.size() > 0)
        {
            Policy policy = policies.get(0);
            list.add(PolicyDto.ApiListItem.builder()
                            .termsName(policy.getPolicyType().getValue())
                            .content(policy.getContents())
                            .isRequiredCheck(true)
                    .build());
        }

        policies = policyRepository.findByPolicyTypeOrderByVersionDesc(PolicyType.POLICY_PRIVACY);

        if (policies.size() > 0)
        {
            Policy policy = policies.get(0);
            list.add(PolicyDto.ApiListItem.builder()
                    .termsName(policy.getPolicyType().getValue())
                    .content(policy.getContents())
                    .isRequiredCheck(true)
                    .build());
        }

        return list;
    }

    /**
     * 약관 조회
     */
    @GetMapping(value = "/terms")
    @ResponseBody
    public PolicyDto.ApiListItem getTerm(PolicyType termsType) {

        List<Policy> policies = policyRepository.findByPolicyTypeOrderByVersionDesc(termsType);

        if (policies.size() > 0)
        {
            Policy policy = policies.get(0);
            return PolicyDto.ApiListItem.builder()
                    .termsName(policy.getPolicyType().getValue())
                    .content(policy.getContents())
                    .isRequiredCheck(true)
                    .build();
        }

        return null;
    }

    /**
     * 앱 버전 조회
     */
    @GetMapping(value = "/version/latest")
    @ResponseBody
    public VersionDto.ApiItem getVersionLastest(AppType osType) {

        return versionQueryRepository.findByAppType(osType);
    }

    /**
     * 콘텐츠 조회
     */
    @GetMapping(value = "/content")
    @ResponseBody
    public List<ContentDto> getContentList(@RequestParam ContentType contentType, Search search) {

        List<ContentDto> list = new ArrayList<>();

        switch (contentType)
        {
            case NEWS:
                list = newsQueryRepository.findAllByContent(search);
                break;
            case EVENT:
                list = eventQueryRepository.findAllByContent(search);
                break;
            case CONGRATULATIONS:
                list = weddingQueryRepository.findAllByContent(search);
                break;
            case HUMAN:
                list = humanQueryRepository.findAllByContent(search);
                break;
        }

        return list;
    }


}
