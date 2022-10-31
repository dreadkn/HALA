package com.inpply.web.project.admin.enc.admin.controller;

import com.inpply.common.domain.user.model.Role;
import com.inpply.common.domain.user.model.User;
import com.inpply.web.common.user.repository.RoleRepository;
import com.inpply.web.common.user.repository.UserRepository;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.global.model.DataTable;
import com.inpply.web.global.model.Search;
import com.inpply.web.global.validator.OnCreate;
import com.inpply.web.global.validator.OnUpdate;
import com.inpply.web.project.admin.enc.admin.dto.AdminDto;
import com.inpply.web.project.admin.enc.admin.repository.AdminQueryRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.groups.Default;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Optional;

@Controller
@RequestMapping("/admin/mng/admin")
@Slf4j
@RequiredArgsConstructor
public class AdminController {

    private final UserRepository userRepository;
    private final AdminQueryRepository adminQueryRepository;
    private final ModelMapper modelMapper;
    private final PasswordEncoder passwordEncoder;
    private final RoleRepository roleRepository;

    @GetMapping
    public String viewList(@PageableDefault Pageable pageable, Search search, Model model) {
        return "admin/mng/admin/admin-list";
    }

    @GetMapping(value = "/list", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public DataTable.Returned<AdminDto> getList(DataTable.Sent sent, Search search) {
        log.debug("DataTables: {}", sent);
        log.debug("Search: {}", search);
        Page<User> page = adminQueryRepository.findAll(sent.getPageable(), search);

        Page<AdminDto> pageDto = page.map(u -> {
            return modelMapper.map(u, AdminDto.class);
        });

        return new DataTable.Returned<>(sent, pageDto);
    }

    @GetMapping({"/form", "/{id}"})
    public String viewForm(@PathVariable(required = false) Long id, Model model) {

        model.addAttribute("item", userRepository.findById(Optional.ofNullable(id).orElse(-1l)).orElse(User.builder().build()));

        return "admin/mng/admin/admin-form";
    }

    @GetMapping(value = "/detail/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public AdminDto get(@PathVariable Long id) {
        User user = userRepository.findById(id)
            .orElseThrow(() -> new EntityNotFoundException("장비", "deviceId", id));

        return modelMapper.map(user, AdminDto.class);
    }

    @PostMapping
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public boolean save(@RequestBody @Validated({Default.class, OnCreate.class}) AdminDto userDto) {

        User user = modelMapper.map(userDto, User.class);

        Role role = roleRepository.findByName(user.getAdminType().getRole())
                .orElseThrow(() -> new EntityNotFoundException("역활", "role", user.getAdminType().getRole()));

        user.setRoles(new HashSet<>(Arrays.asList(role)));
        user.setEnabled(true);
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        User result = userRepository.save(user);
        return result == null ? false : true;
    }

    @PutMapping("/{id}")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.NO_CONTENT)
    public void update(@PathVariable String id, @RequestBody @Validated({Default.class, OnUpdate.class}) AdminDto userDto) {

        userDto.setId(Long.parseLong(id));

        User user = modelMapper.map(userDto, User.class);

        Role role = roleRepository.findByName(user.getAdminType().getRole())
                .orElseThrow(() -> new EntityNotFoundException("역활", "role", user.getAdminType().getRole()));

        user.setRoles(new HashSet<>(Arrays.asList(role)));

        if (user.isEnabled())
            user.setFailCnt(0);

        userRepository.save(user);
    }

    @DeleteMapping("/{id}")
    @ResponseBody
    public void delete(@PathVariable Long id) {
        userRepository.deleteById(id);
    }

    @PostMapping(value = "/check/overlap/{userId}", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public boolean checkOverlap(@PathVariable String userId) {
        User result = userRepository.findByUserId(userId).orElse(null);
        return result == null ? false : true;
    }
}
