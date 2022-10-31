package com.inpply.web.global.error;

import com.inpply.global.exception.BusinessException;
import com.inpply.web.global.exception.EntityNotFoundException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.MessageSource;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

//@ControllerAdvice
@Slf4j
public class GlobalExceptionHandler {

    @Qualifier("messageSource")
    @Autowired
    private MessageSource messageSource;

    @ExceptionHandler(EntityNotFoundException.class)
    public String entityNotFoundException(Model model, Exception e) {

        model.addAttribute("exception", e);
        return "error/400";
    }

    @ExceptionHandler(BusinessException.class)
    public String businessException(Model model, Exception e) {

        model.addAttribute("exception", e);
        return "error/500";
    }

    @ExceptionHandler(RuntimeException.class)
    public String errorException(Model model, Exception e) {

        model.addAttribute("exception", e);
        return "error/500";
    }

    private String getMessage(String message, WebRequest request) {
        return messageSource.getMessage(message, null, message, request.getLocale());
    }
}
