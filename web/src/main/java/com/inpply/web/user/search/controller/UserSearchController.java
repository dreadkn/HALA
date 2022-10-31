package com.inpply.web.user.search.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/search")
@RequiredArgsConstructor
@Slf4j
public class UserSearchController {

    @GetMapping
    public String search(Model model) {
        return "/user/search/search-list";
    }
}
