package com.inpply.web.project.admin.content.event.dto;

import com.inpply.common.domain.file.model.File;
import com.inpply.web.global.dto.BaseDto;
import com.inpply.web.module.banner.type.BannerType;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import java.util.List;

@Data
public class EventDto extends BaseDto {

    private Boolean isPublic;
    @NotBlank(message = "제목을 입력하세요.")
    private String title;
    @NotBlank(message = "내용을 입력하세요.")
    private String content;
    private String homepageUrl;
    private String youtubeUrl;
    private Integer readCount;
    private String name;
    List<File> files;

    Boolean isUse;
    Integer sort;

    @Data
    public static class ApiItem extends BaseDto {
        @NotBlank(message = "제목을 입력하세요.")
        private String title;
        @NotBlank(message = "내용을 입력하세요.")
        private String content;
        private String homepageUrl;
        private String youtubeUrl;
        private String createdName;
        List<File> files;
    }


    @Data
    public static class ListItem extends BaseDto {
        private Boolean isPublic;
        private String title;
        private String name;
        private Integer readCount;
        private String content;
        Long fileId;
    }

    @Data
    public static class ApiListItem extends BaseDto {
        private String title;
        private String createdName;
        private String content;
        private File file;
        Long fileId;
    }
}
