package com.inpply.web.project.api.ad.controller;

import com.inpply.common.domain.entity.AdPolicy;
import com.inpply.common.domain.repository.AdPolicyRepository;
import com.inpply.common.domain.repository.AdRepository;
import com.inpply.common.domain.type.AdType;
import com.inpply.common.domain.type.ContentType;
import com.inpply.web.common.board.dto.ArticleDto;
import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.ad.dto.AdDto;
import com.inpply.web.project.admin.ad.repository.AdQueryRepository;
import com.inpply.web.project.admin.ad.service.AdService;
import com.inpply.web.project.admin.content.check.service.CheckService;
import com.inpply.web.project.admin.content.event.dto.EventDto;
import com.inpply.web.project.admin.content.event.service.EventService;
import com.inpply.web.project.admin.content.human.dto.HumanDto;
import com.inpply.web.project.admin.content.human.service.HumanService;
import com.inpply.web.project.admin.content.news.dto.NewsDto;
import com.inpply.web.project.admin.content.news.service.NewsService;
import com.inpply.web.project.admin.content.wedding.dto.WeddingDto;
import com.inpply.web.project.admin.content.wedding.service.WeddingService;
import com.inpply.web.project.admin.enc.policy.dto.AdPolicyDto;
import com.inpply.web.project.admin.enc.policy.service.AdPolicyService;
import com.inpply.web.project.api.common.dto.ResultDto;
import com.inpply.web.security.AuthenticationHelper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.math3.analysis.function.Add;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.transaction.Transactional;
import javax.validation.Valid;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/api/v1/ad")
@Slf4j
@RequiredArgsConstructor
@Transactional
public class AdApiControllerV1 {

    private final AdPolicyRepository adPolicyRepository;
    private final AdQueryRepository adQueryRepository;
    private final AdService adService;
    private final ModelMapper modelMapper;

    /**
     * ??? ?????? ??????
     */
    @GetMapping(value = "/my")
    @ResponseBody
    public Page<AdDto.ApiListDto> getListByAd(@PageableDefault(direction = Sort.Direction.DESC, sort = "createdDate") Pageable pageable, Search search) {

        Page<AdDto.ApiListDto> page = adQueryRepository.findAllByUser(pageable, AuthenticationHelper.getId().orElseGet(() -> 0l));

        return page;
    }

    /**
     * ????????? ??????
     */
    @GetMapping(value = "/detail")
    @ResponseBody
    public AdDto.ApiDto getAdDetail(Long id) {

        AdDto.ApiDto page = modelMapper.map(adService.getDto(id), AdDto.ApiDto.class);

        return page;
    }


    /**
     * ?????? ????????? ?????? ??????
     */
    @GetMapping(value = "/policy")
    @ResponseBody
    public List<AdPolicyDto.ApiDto> getAdPolicy() {

        List<AdPolicyDto.ApiDto> list = new ArrayList<>();

        Arrays.stream(AdType.values()).forEach(adType -> {
            List<AdPolicy> adPolicies = adPolicyRepository.findByAdTypeAndStartDateBeforeAndEndDateAfterOrderByStartDateDesc(adType, LocalDateTime.now(), LocalDateTime.now());

            if (adPolicies.size() > 0)
            {
                AdPolicy adPolicy = adPolicies.get(0);
                list.add(AdPolicyDto.ApiDto.builder()
                        .adType(adPolicy.getAdType())
                        .price(adPolicy.getPrice())
                        .build());
            }

        });

        return list;
    }

    /**
     * ?????? ??????/??????
     */
    @PostMapping
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public ResultDto.Result saveAd(@RequestBody @Valid AdDto.ApiDto adDto) {
        ResultDto.Result result = new ResultDto.Result();

        try{

            Long id = 0l;

            if(adDto.getId() == null)
            {
                id = adService.save(adDto);
            }
            else
            {
                id = adService.update(adDto.getId(), adDto);
            }
            result.setSuccess(id);

        } catch (Exception e){
            result.setFail("????????? ????????? ??????????????????.");
        }

        return result;
    }

    /**
     * ?????? ??????
     */
    @PostMapping("/delete")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public ResultDto.Result deleteAd(@RequestBody AdDto.ApiDto adDto) {
        ResultDto.Result result = new ResultDto.Result();

        try{

            adService.delete(adDto.getId());

            result.setSuccess(adDto.getId());

        } catch (Exception e){
            result.setFail("????????? ????????? ??????????????????.");
        }

        return result;
    }


}
