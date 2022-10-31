package com.inpply.web.project.admin.login.controller;

import com.inpply.web.common.user.service.UserService;
import com.inpply.web.security.AuthenticationHelper;
import java.util.Locale;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin")
@Slf4j
@RequiredArgsConstructor
public class LoginController {

    private final UserService userService;
    private final MessageSource messages;

    @GetMapping("/login")
    public String login() {
        if (AuthenticationHelper.isAuthenticated()) {
            return "redirect:/admin";
        }
        return "admin/login/login";
    }

    /**
     * 비밀번호 찾기 페이지.
     */
    @GetMapping("/forgotPassword")
    public String viewForgotPassword() {
        return "admin/login/forgot-password";
    }

    /**
     * 비밀번호 복구 페이지.
     */
    @GetMapping("/recoverPassword")
    public String viewRecoverPassword() {
        return "admin/login/recover-password";
    }

    /**
     * 비밀번호 복구 링크 페이지.
     */
    @GetMapping("/changePassword")
    public String showChangePasswordPage(final Locale locale, final Model model, @RequestParam("id") final long id,
        @RequestParam("token") final String token) {
        final String result = userService.validatePasswordResetToken(id, token);
        if (result != null) {
            model.addAttribute("message", messages.getMessage("auth.message." + result, null, locale));
            return "redirect:/admin/login?lang=" + locale.getLanguage();
        }
        return "redirect:/admin/recoverPassword";
    }
}
