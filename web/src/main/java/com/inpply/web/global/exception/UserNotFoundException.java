package com.inpply.web.global.exception;

import com.inpply.global.exception.BusinessException;
import org.springframework.util.StringUtils;

public final class UserNotFoundException extends BusinessException {

    private static final String DEFAULT_MESSAGE = "message.userNotFound";

    private static final long serialVersionUID = 5861310537366287163L;

    public UserNotFoundException() {
        super();
    }

    public UserNotFoundException(final String message, final Throwable cause) {
        super(message, cause);
    }

    public UserNotFoundException(final String message) {
        super(message);
    }

    public UserNotFoundException(String message, String fieldOrObjectName) {
        super(StringUtils.isEmpty(message) ? DEFAULT_MESSAGE : message, fieldOrObjectName);
    }

    public UserNotFoundException(final Throwable cause) {
        super(cause);
    }

}
