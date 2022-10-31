package com.inpply.web.global.interceptor;

import com.inpply.web.common.system.dto.MenuDto.Detail;
import com.inpply.web.common.system.service.MenuMngService;
import com.inpply.web.common.system.type.MenuType;
import com.inpply.web.security.AuthenticationHelper;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Component
@RequiredArgsConstructor
@Slf4j
public class MenuInterceptor extends HandlerInterceptorAdapter {

    private final MenuMngService menuMngService;

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
        ModelAndView modelAndView) throws Exception {

        if (!request.getMethod().toLowerCase().equals("get") || modelAndView == null) {
            return;
        }

        MenuType menuType = request.getServletPath().contains("/admin") ? MenuType.ADMIN : MenuType.USER;
        List<Detail> allMenus = menuMngService.getAllMenus(menuType);

        List<String> grantedAuthorities = AuthenticationHelper.getAuthenticatedUser()
            .map(User::getAuthorities).orElse(Collections.emptyList()).stream()
            .map(GrantedAuthority::getAuthority).collect(Collectors.toList());

        List<Detail> filteredMenus = allMenus.stream()
            .filter(menu -> menu.hasAuthority(grantedAuthorities)).collect(Collectors.toList());
        filteredMenus.forEach(menu -> menu.filterMenu(grantedAuthorities));

        modelAndView.getModelMap().addAttribute("menus", filteredMenus);
    }
}
