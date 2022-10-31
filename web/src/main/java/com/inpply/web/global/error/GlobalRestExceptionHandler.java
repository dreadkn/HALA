package com.inpply.web.global.error;

import com.inpply.global.exception.BusinessException;
import com.inpply.web.global.exception.UserAlreadyExistException;
import com.inpply.web.global.exception.UserNotFoundException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.TypeMismatchException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.firewall.RequestRejectedException;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@RestControllerAdvice
@Slf4j
public class GlobalRestExceptionHandler extends ResponseEntityExceptionHandler {

    @Qualifier("messageSource")
    @Autowired
    private MessageSource messageSource;

    // 400
    @Override
    protected ResponseEntity<Object> handleBindException(final BindException ex, final HttpHeaders headers,
        final HttpStatus status, final WebRequest request) {
        log.debug("400 Status Code: {}", ex.getLocalizedMessage());
        final BindingResult result = ex.getBindingResult();
        final GenericResponse bodyOfResponse = GenericResponse.of("Invalid" + result.getObjectName(), result);
        return handleExceptionInternal(ex, bodyOfResponse, new HttpHeaders(), HttpStatus.BAD_REQUEST, request);
    }

    @Override
    protected ResponseEntity<Object> handleMethodArgumentNotValid(final MethodArgumentNotValidException ex,
        final HttpHeaders headers, final HttpStatus status, final WebRequest request) {
        log.debug("400 Status Code: {}", ex.getLocalizedMessage());
        final BindingResult result = ex.getBindingResult();
        final GenericResponse bodyOfResponse = GenericResponse.of("Invalid" + result.getObjectName(), result);
        return handleExceptionInternal(ex, bodyOfResponse, new HttpHeaders(), HttpStatus.BAD_REQUEST, request);
    }

    @Override
    protected ResponseEntity<Object> handleTypeMismatch(TypeMismatchException ex, HttpHeaders headers,
        HttpStatus status, WebRequest request) {
        log.debug("400 Status Code: {}", ex.getLocalizedMessage());
        final GenericResponse bodyOfResponse = GenericResponse.of(ex.getLocalizedMessage());
        return handleExceptionInternal(ex, bodyOfResponse, new HttpHeaders(), HttpStatus.BAD_REQUEST, request);
    }

    @ExceptionHandler({BusinessException.class})
    public ResponseEntity<Object> handleBusiness(final BusinessException ex, final WebRequest request) {
        log.debug("400 Status Code: {}", ex.getLocalizedMessage());
        final GenericResponse bodyOfResponse = GenericResponse
            .of(getMessage(ex.getLocalizedMessage(), request), ex.getFieldOrObjectName(), ex.getValue());
        return handleExceptionInternal(ex, bodyOfResponse, new HttpHeaders(), HttpStatus.BAD_REQUEST, request);
    }

    // 401
    @ExceptionHandler({AccessDeniedException.class, AuthenticationException.class})
    protected ResponseEntity<Object> handleAccessDeniedException(final RuntimeException ex, WebRequest request) {
        log.debug("401 Status Code: {}", ex.getLocalizedMessage());
        final GenericResponse bodyOfResponse = GenericResponse.of(ex.getLocalizedMessage());
        return handleExceptionInternal(ex, bodyOfResponse, new HttpHeaders(), HttpStatus.UNAUTHORIZED, request);
    }

    // 404
    @ExceptionHandler({UserNotFoundException.class})
    public ResponseEntity<Object> handleUserNotFound(final RuntimeException ex, final WebRequest request) {
        log.debug("404 Status Code: {}", ex.getLocalizedMessage());
        final GenericResponse bodyOfResponse = GenericResponse
            .of("UserNotFound", "userId", getMessage("message.userNotFound", request));
        return handleExceptionInternal(ex, bodyOfResponse, new HttpHeaders(), HttpStatus.NOT_FOUND, request);
    }

    // 409
    @ExceptionHandler({UserAlreadyExistException.class})
    public ResponseEntity<Object> handleUserAlreadyExist(final RuntimeException ex, final WebRequest request) {
        log.debug("409 Status Code: {}", ex.getLocalizedMessage());
        final GenericResponse bodyOfResponse = GenericResponse
            .of("UserAlreadyExist", "userId", getMessage("message.regError", request));
        return handleExceptionInternal(ex, bodyOfResponse, new HttpHeaders(), HttpStatus.CONFLICT, request);
    }

    // 500
    @ExceptionHandler({Exception.class})
    public ResponseEntity<Object> handleInternal(final RuntimeException ex, final WebRequest request) {
        log.debug("500 Status Code: {}", ex.getLocalizedMessage());
        final GenericResponse bodyOfResponse = GenericResponse
            .of("InternalError", "", getMessage("message.error", request));
        return new ResponseEntity<Object>(bodyOfResponse, new HttpHeaders(), HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @ExceptionHandler({RequestRejectedException.class})
    public ResponseEntity<Object> handleRequestRejectedException(final RequestRejectedException ex,
        final WebRequest request) {
        log.debug("500 Status Code: {}", ex.getLocalizedMessage());
        final GenericResponse bodyOfResponse = GenericResponse
            .of("InternalError", "", getMessage("message.error", request));
        return new ResponseEntity<Object>(bodyOfResponse, new HttpHeaders(), HttpStatus.NOT_FOUND);
    }

    private String getMessage(String message, WebRequest request) {
        return messageSource.getMessage(message, null, message, request.getLocale());
    }
}
