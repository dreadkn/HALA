package com.inpply.web.project.admin.enc.version.dto;

import com.inpply.common.converter.BooleanToYNConverter;
import com.inpply.common.domain.file.model.File;
import com.inpply.common.domain.type.AppType;
import com.inpply.web.global.dto.BaseDto;
import com.inpply.web.module.banner.type.BannerType;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Convert;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;

@Data
public class VersionDto extends BaseDto {

    private AppType appType;
    @NotBlank(message = "버전을 입력하세요.")
    private String version;
    private Boolean isEssentialUpdate;

    @Data
    public static class ApiItem extends BaseDto {
        private String version;
        private Boolean isRequiredUpdate;
    }

    @Data
    public static class ListItem extends BaseDto {
        private AppType appType;
        private String version;
        private Boolean isEssentialUpdate;
    }
}
