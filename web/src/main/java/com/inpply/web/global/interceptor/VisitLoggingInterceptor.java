package com.inpply.web.global.interceptor;

import com.inpply.web.common.visit.model.Visit;
import com.inpply.web.common.visit.repository.VisitRepository;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Component
@RequiredArgsConstructor
@Slf4j
public class VisitLoggingInterceptor extends HandlerInterceptorAdapter {

    private final VisitRepository visitRepository;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
        throws Exception {

        String contentType = request.getContentType();
        if (contentType != null && contentType.equals(MediaType.APPLICATION_JSON_VALUE)) {
            return true;
        }

        HttpSession session = request.getSession();
        String visited = (String) session.getAttribute("visit");

        boolean visitTimeout;
        if (StringUtils.hasText(visited)) {

            LocalDateTime visitedTime = LocalDateTime.parse(visited, DateTimeFormatter.ISO_DATE_TIME);
            visitTimeout = visitedTime.isBefore(LocalDateTime.now().minusSeconds(5));
        } else {
            visitTimeout = true;
        }

        if (visitTimeout) {
            session.setAttribute("visit", LocalDateTime.now().format(DateTimeFormatter.ISO_DATE_TIME));

            String ip = request.getRemoteAddr();
            String name = request.getMethod();
            HttpMethod method = HttpMethod.valueOf(name);
            String uri = request.getRequestURI();
            String referer = request.getHeader("referer");
            visitRepository.save(Visit.of(ip, method, uri, referer));
        }

        return super.preHandle(request, response, handler);
    }
}
