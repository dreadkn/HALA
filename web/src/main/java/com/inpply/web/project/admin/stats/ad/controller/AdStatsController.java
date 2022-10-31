package com.inpply.web.project.admin.stats.ad.controller;

import com.inpply.common.domain.repository.AdRepository;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.stats.dto.StatsDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin/stats-ad")
@Slf4j
@RequiredArgsConstructor
public class AdStatsController {

    private final AdRepository adRepository;

    @GetMapping
    public String viewList(@PageableDefault Pageable pageable, Search search, Model model) {
        return "admin/stats-ad/stats-ad-list";
    }

    @GetMapping(value = "/chart")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public List<StatsDto> getChart(Search search) {
        List<Object[]> list = adRepository.findByStats(search.getStartDate(), search.getEndDate());

        List<StatsDto> statsDtos = new ArrayList<>();

        list.stream().forEach(objects -> {
            StatsDto statsDto = new StatsDto();
            statsDto.setCreatedDate((String) objects[0]);
            statsDto.setCnt((BigInteger) objects[1]);

            statsDtos.add(statsDto);
        });

        return statsDtos;
    }
}
