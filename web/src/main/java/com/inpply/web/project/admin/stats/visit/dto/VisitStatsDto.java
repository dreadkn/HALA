package com.inpply.web.project.admin.stats.visit.dto;

import com.inpply.common.domain.file.model.File;
import com.inpply.web.global.dto.BaseDto;
import com.inpply.web.module.banner.type.BannerType;
import lombok.Data;

import javax.validation.constraints.NotEmpty;
import java.util.List;

@Data
public class VisitStatsDto extends BaseDto {

    @NotEmpty(message = "링크를 입력하세요.")
    String url;

    @NotEmpty(message = "배너링크제목을 입력하세요.")
    String urlTitle;

    @NotEmpty(message = "설명을 입력하세요.")
    String content;

    BannerType bannerType;

    List<File> files;

    Boolean isUse;
    Integer sort;

    @Data
    public static class ListItem extends BaseDto {

    }
}
