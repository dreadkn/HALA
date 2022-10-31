package com.inpply.web.project.admin.calendar.controller;

import com.inpply.common.domain.calendar.repository.ScheduleRepository;
import com.inpply.common.domain.file.model.File;
import com.inpply.common.domain.file.repository.FileRepository;
import com.inpply.common.domain.pdf.model.MakePdf;
import com.inpply.common.domain.pdf.repository.MakePdfRepository;
import com.inpply.web.common.file.dto.FileDto;
import com.inpply.web.common.file.service.FileService;
import com.inpply.web.common.pdf.service.PdfService;
import com.inpply.web.common.user.repository.UserRepository;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.calendar.dto.ScheduleDto;
import com.inpply.web.project.admin.calendar.repository.ScheduleQueryRepository;
import com.inpply.web.project.admin.calendar.service.ScheduleService;
import com.inpply.web.project.admin.pdf.dto.MakePdfDto;
import com.inpply.web.project.admin.pdf.repository.MakePdfQueryRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.ImageType;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.apache.pdfbox.tools.imageio.ImageIOUtil;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.thymeleaf.context.Context;

import javax.validation.Valid;
import java.awt.image.BufferedImage;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin/mng/calendar")
@Slf4j
@RequiredArgsConstructor
public class CalendarController {

    private final ScheduleRepository scheduleRepository;
    private final ScheduleQueryRepository scheduleQueryRepository;
    private final ScheduleService scheduleService;
    @GetMapping
    public String viewCalendar() {
        return "admin/calendar/calendar";
    }

    @GetMapping("/sample")
    public String viewCalendarSample() {
        return "admin/calendar/calendar-sample";
    }

    @GetMapping(value = "/schedules")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public List getScheduleList(Search search) {
        return scheduleQueryRepository.findAll(search);
    }

    @PostMapping
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Long save(@RequestBody @Valid ScheduleDto request) {

        return scheduleService.saveSchedule(request);
    }

    @PutMapping("/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.NO_CONTENT)
    public void update(@PathVariable Long id, @RequestBody @Valid ScheduleDto request) {

        scheduleService.updateSchedule(request);
    }

    @DeleteMapping("/{id}")
    @ResponseBody
    public void delete(@PathVariable Long id) {
        scheduleService.deleteSchedule(id);
    }

}
