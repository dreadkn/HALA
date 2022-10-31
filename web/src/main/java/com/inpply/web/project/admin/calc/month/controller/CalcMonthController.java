package com.inpply.web.project.admin.calc.month.controller;

import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.calc.month.dto.CalcMonthDto;
import com.inpply.web.project.admin.calc.month.repository.CalcMonthQueryRepository;
import com.inpply.web.project.admin.calc.month.service.CalcMonthService;
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

@Controller
@RequestMapping("/admin/calc-month")
@Slf4j
@RequiredArgsConstructor
public class CalcMonthController {

    private final CalcMonthQueryRepository calcMonthQueryRepository;

    private final CalcMonthService calcMonthService;

    @GetMapping
    public String viewList(@PageableDefault Pageable pageable, Search search, Model model) {
        return "admin/calc-month/calc-month-list";
    }

    @GetMapping(value = "/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public DataTable.Returned<CalcMonthDto> getList(DataTable.Sent sent, Search search) {
        log.debug("DataTables: {}", sent);
        log.debug("Search: {}", search);

        Page<CalcMonthDto> page = calcMonthQueryRepository.findAll(sent.getPageable(), search);

        return new DataTable.Returned<>(sent, page);
    }

    @GetMapping({"/form", "/{id}"})
    public String viewForm(@PathVariable(required = false) Long id, Model model) {

        model.addAttribute("id", id);

        return "admin/calc-month/calc-month-form";
    }

    @GetMapping(value = "/detail/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public CalcMonthDto get(@PathVariable Long id) {
        return calcMonthService.getDto(id);
    }

    @PostMapping
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Long save(@RequestBody @Valid CalcMonthDto calcMonthDto) {

        return calcMonthService.save(calcMonthDto);
    }

    @PutMapping("/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.NO_CONTENT)
    public Long update(@PathVariable Long id, @RequestBody @Valid CalcMonthDto calcMonthDto) {

        return calcMonthService.update(id, calcMonthDto);
    }

    @DeleteMapping("/{id}")
    @ResponseBody
    public void delete(@PathVariable Long id) {
        calcMonthService.delete(id);
    }
}
