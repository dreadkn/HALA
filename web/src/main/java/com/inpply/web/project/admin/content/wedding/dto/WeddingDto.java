package com.inpply.web.project.admin.content.wedding.dto;

import com.inpply.common.domain.file.model.File;
import com.inpply.common.domain.type.CongratulationsType;
import com.inpply.web.global.dto.BaseDto;
import com.inpply.web.module.banner.type.BannerType;
import lombok.Data;

import javax.persistence.Column;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import java.util.List;

@Data
public class WeddingDto extends BaseDto {

    private Boolean isPublic;
    @NotBlank(message = "제목을 입력하세요.")
    private String title;
    private String content;
    private String homepageUrl;
    private String youtubeUrl;
    private Integer readCount;

    List<File> files;
    File file;

    private CongratulationsType dtype;

    String groom;
    String groomJob;
    String groomFather;
    String groomMother;
    String bride;
    String brideJob;
    String brideFather;
    String brideMother;
    String weddingDate;
    String place;
    String partyDate;
    String partyPlace;

    String deceased;
    String deceasedJob;
    String illpho;
    String outDate;
    String cemetery;
    String createdName;
    Long fileId;

    @Data
    public static class ListItem extends BaseDto {
        private CongratulationsType dtype;
        private Boolean isPublic;
        private String title;
        private String name;
        private Integer readCount;
    }
}
