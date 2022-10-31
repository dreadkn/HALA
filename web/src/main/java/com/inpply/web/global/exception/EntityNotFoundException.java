package com.inpply.web.global.exception;

import com.inpply.global.exception.BusinessException;

public class EntityNotFoundException extends BusinessException {

    private String resourceName;
    private String fieldName;
    private Object fieldValue;

    public EntityNotFoundException(String resourceName, String fieldName, Object fieldValue) {
        super(String.format("%s not found with %s : '%s'", resourceName, fieldName, fieldValue));
        this.resourceName = resourceName;
        this.fieldName = fieldName;
        this.fieldValue = fieldValue;
    }

    public String getResourceName() {
        return resourceName;
    }

    public String getFieldName() {
        return fieldName;
    }

    public Object getFieldValue() {
        return fieldValue;
    }
}
