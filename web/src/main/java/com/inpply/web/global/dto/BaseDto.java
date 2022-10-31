package com.inpply.web.global.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class BaseDto {

    private Long id;
    private Long createdBy;
    private Long modifiedBy;

    protected LocalDateTime createdDate;
    protected LocalDateTime modifiedDate;
}
