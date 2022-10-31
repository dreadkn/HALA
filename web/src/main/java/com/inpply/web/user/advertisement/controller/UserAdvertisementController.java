package com.inpply.web.user.advertisement.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/advertisement")
@RequiredArgsConstructor
@Slf4j
public class UserAdvertisementController {

    @GetMapping
    public String list(Model model) {
        return "/user/advertisement/advertisement-list";
    }
    @GetMapping(value = "/form")
    public String form(Model model) {
        return "/user/advertisement/advertisement-form";
    }
}
