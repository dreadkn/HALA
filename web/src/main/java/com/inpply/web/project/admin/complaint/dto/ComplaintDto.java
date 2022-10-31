package com.inpply.web.project.admin.complaint.dto;

import com.inpply.common.domain.file.model.File;
import com.inpply.common.domain.type.BrokenStatus;
import com.inpply.common.domain.type.BrokenType;
import com.inpply.web.global.dto.BaseDto;
import com.inpply.web.module.banner.type.BannerType;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import java.util.List;

@Data
public class ComplaintDto extends BaseDto {

    private BrokenType brokenType;
    private BrokenStatus brokenStatus;
    @NotBlank(message = "제목을 입력하세요.")
    private String title;
    @NotBlank(message = "내용을 입력하세요.")
    private String content;
    private String answer;
    @NotBlank(message = "이메일을 입력하세요.")
    private String email;
    private Integer readCount;
    List<File> files;

    @Data
    public static class ListItem extends BaseDto {
        private BrokenType brokenType;
        private BrokenStatus brokenStatus;
        private String title;
        private Integer readCount;
        private String name;
    }
}
