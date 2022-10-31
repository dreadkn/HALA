package com.inpply.web.project.admin.dashboard.controller;

import com.inpply.web.common.visit.repository.VisitRepository;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.dashboard.dto.VisitDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin/main")
@RequiredArgsConstructor
@Slf4j
public class MainController {

    final VisitRepository visitRepository;

    @GetMapping
    public String viewDashboard(Model model) {

        return "admin/dashboard/main";
    }

    @GetMapping(value = "/chart/connection")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public List<VisitDto.Connection> getConnectionChart(Search search) {
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

    @GetMapping(value = "/chart/media")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public List<VisitDto.Media> getMediaChart(Search search) {
        List<Object[]> list = visitRepository.findByMediaStats(search.getStartDate(), search.getEndDate());

        List<VisitDto.Media> visits = new ArrayList<>();

        list.stream().forEach(objects -> {
            VisitDto.Media visit = new VisitDto.Media();
            visit.setReferer((String) objects[0]);
            visit.setVisitCnt((BigInteger) objects[1]);

            visits.add(visit);
        });

        return visits;
    }
}
