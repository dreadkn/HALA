package com.inpply.web.project.admin.stats.visit.controller;

import com.inpply.web.common.visit.repository.VisitRepository;
import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.dashboard.dto.VisitDto;
import com.inpply.web.project.admin.stats.visit.dto.VisitStatsDto;
import com.inpply.web.project.admin.stats.visit.repository.VisitStatsQueryRepository;
import com.inpply.web.project.admin.stats.visit.service.VisitStatsService;
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

import javax.validation.Valid;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin/stats-visit")
@Slf4j
@RequiredArgsConstructor
public class VisitStatsController {

    private final VisitStatsQueryRepository visitStatsQueryRepository;

    private final VisitStatsService visitStatsService;
    private final VisitRepository visitRepository;

    @GetMapping
    public String viewList(@PageableDefault Pageable pageable, Search search, Model model) {
        return "admin/stats-visit/stats-visit-list";
    }

    @GetMapping(value = "/chart")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public List<VisitDto.Connection> getChart(Search search) {
        List<Object[]> list = visitRepository.findByConnectionStats(search.getStartDate(), search.getEndDate());

        List<VisitDto.Connection> visits = new ArrayList<>();

        list.stream().forEach(objects -> {
            VisitDto.Connection visit = new VisitDto.Connection();
            visit.setCreatedDate((String) objects[0]);
            visit.setVisitCnt((BigInteger) objects[1]);

            visits.add(visit);
        });

        return visits;
    }
}
