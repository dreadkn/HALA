package com.inpply.web.global.interceptor;

import com.inpply.web.global.util.CookieUtils;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LayoutInterceptor extends HandlerInterceptorAdapter {

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
        ModelAndView modelAndView) throws Exception {

        if (modelAndView != null) {
            CookieUtils.getCookie(request, "toggleSidebar").ifPresent(cookie -> {
                modelAndView.getModelMap().addAttribute("toggleSidebar", cookie.getValue());
            });
            CookieUtils.getCookie(request, "navFlat").ifPresent(cookie -> {
                modelAndView.getModelMap().addAttribute("navFlat", cookie.getValue());
            });
        }
    }
}
