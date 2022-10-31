package com.inpply.web.user.ad.controller;

import com.inpply.common.domain.type.AdType;
import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.ad.dto.AdDto;
import com.inpply.web.project.admin.ad.repository.AdQueryRepository;
import com.inpply.web.project.admin.content.wedding.dto.WeddingDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.math3.analysis.function.Add;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/banner")
@RequiredArgsConstructor
@Slf4j
public class UserAdController {

    private final AdQueryRepository adQueryRepository;

    @GetMapping(value = "/main", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public AdDto.ApiListDto getMain() {

        List<AdDto.ApiListDto> list = adQueryRepository.findAllByApprove();

        Optional<AdDto.ApiListDto> item = list.stream().filter(apiListDto -> apiListDto.getAdType().equals(AdType.MAIN_BANNER)).findFirst();

        return item.orElseGet(() -> new AdDto.ApiListDto());
    }

    @GetMapping(value = "/side", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public AdDto.ApiListDto getSide() {

        List<AdDto.ApiListDto> list = adQueryRepository.findAllByApprove();

        Optional<AdDto.ApiListDto> item = list.stream().filter(apiListDto -> apiListDto.getAdType().equals(AdType.SIDE_BANNER)).findFirst();

        return item.orElseGet(() -> new AdDto.ApiListDto());
    }

    @GetMapping(value = "/bottom", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<AdDto.ApiListDto> getBottom() {

        List<AdDto.ApiListDto> list = adQueryRepository.findAllByApprove();

        list = list.stream().filter(apiListDto -> apiListDto.getAdType().equals(AdType.CONTENT_BOTTOM)).limit(3).collect(Collectors.toList());

        return list;
    }
}
