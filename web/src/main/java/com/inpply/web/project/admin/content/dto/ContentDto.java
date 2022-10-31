package com.inpply.web.project.admin.content.dto;

import com.inpply.common.domain.file.model.File;
import com.inpply.common.domain.type.ContentType;
import com.inpply.web.global.dto.BaseDto;
import lombok.Data;

@Data
public class ContentDto extends BaseDto {
    ContentType contentType;
    String title;
    Long fileId;
    String createdName;
}
