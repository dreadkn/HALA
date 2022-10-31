package com.inpply.web.global.error;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@JsonInclude(Include.NON_NULL)
public class GenericResponse {

    private String message = "";
    private List<BindingError> errors = new ArrayList<>();
    private Date timestamp;

    public GenericResponse(String message) {
        this.message = message;
        this.timestamp = new Date();
    }

    public GenericResponse(List<BindingError> errors) {
        this.errors = errors;
        this.timestamp = new Date();
    }

    public GenericResponse(String message, List<BindingError> errors) {
        this.message = message;
        this.errors = errors;
        this.timestamp = new Date();
    }

    public static GenericResponse of() {
        return new GenericResponse();
    }

    public static GenericResponse of(String message) {
        return new GenericResponse(message, Collections.emptyList());
    }

    public static GenericResponse of(BindingResult bindingResult) {
        return new GenericResponse(bindingErrors(bindingResult));
    }

    public static GenericResponse of(String message, BindingResult bindingResult) {
        return new GenericResponse(message, bindingErrors(bindingResult));
    }

    public static GenericResponse of(String message, String fieldOrObjectName, String value) {
        if (value == null) {
            return new GenericResponse(message,
                Collections.singletonList(ObjectErrorDto.of(fieldOrObjectName, message)));
        } else {
            return new GenericResponse(message,
                Collections.singletonList(FieldErrorDto.of(fieldOrObjectName, value, message)));
        }
    }

    private static List<BindingError> bindingErrors(BindingResult bindingResult) {
        return bindingResult.getAllErrors().stream().map(e -> {
            if (e instanceof org.springframework.validation.FieldError) {
                return FieldErrorDto.of(e);
            } else {
                return ObjectErrorDto.of(e);
            }
        }).collect(Collectors.toList());
    }

    interface BindingError {

    }

    @Getter
    @NoArgsConstructor(access = AccessLevel.PROTECTED)
    public static class FieldErrorDto implements BindingError {

        private String field;
        private String value;
        private String reason;

        private FieldErrorDto(String field, String value, String reason) {
            this.field = field;
            this.value = value;
            this.reason = reason;
        }

        private static FieldErrorDto of(String field, String value, String reason) {
            return new FieldErrorDto(field, value, reason);
        }

        private static FieldErrorDto of(ObjectError error) {
            org.springframework.validation.FieldError e = (org.springframework.validation.FieldError) error;
            return new FieldErrorDto(e.getField(), e.getRejectedValue() == null ? "" : e.getRejectedValue().toString(),
                e.getDefaultMessage());
        }

    }

    @Getter
    @NoArgsConstructor(access = AccessLevel.PROTECTED)
    public static class ObjectErrorDto implements BindingError {

        private String object;
        private String reason;

        private ObjectErrorDto(String object, String reason) {
            this.object = object;
            this.reason = reason;
        }

        private static ObjectErrorDto of(String objectName, String reason) {
            return new ObjectErrorDto(objectName, reason);
        }

        private static ObjectErrorDto of(ObjectError error) {
            return new ObjectErrorDto(error.getObjectName(), error.getDefaultMessage());
        }
    }


}
