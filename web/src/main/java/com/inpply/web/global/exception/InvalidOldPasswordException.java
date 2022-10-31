package com.inpply.web.global.exception;

import com.inpply.global.exception.BusinessException;
import org.springframework.util.StringUtils;

public final class InvalidOldPasswordException extends BusinessException {

    private static final long serialVersionUID = 5861310537366287163L;
    private static final String DEFAULT_MESSAGE = "message.invalidOldPassword";

    public InvalidOldPasswordException() {
        super(DEFAULT_MESSAGE);
    }

    public InvalidOldPasswordException(final String message, final Throwable cause) {
        super(message, cause);
    }

    public InvalidOldPasswordException(final String message) {
        super(message);
    }

    public InvalidOldPasswordException(final Throwable cause) {
        super(cause);
    }

    public InvalidOldPasswordException(String message, String filed) {
        super(StringUtils.isEmpty(message) ? DEFAULT_MESSAGE : message, filed, "");
    }
}
