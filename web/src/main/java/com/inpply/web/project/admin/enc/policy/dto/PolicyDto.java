package com.inpply.web.project.admin.enc.policy.dto;

import com.inpply.common.domain.file.model.File;
import com.inpply.common.domain.type.PolicyType;
import com.inpply.web.common.board.domain.Board;
import com.inpply.web.global.dto.BaseDto;
import lombok.Builder;
import lombok.Data;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;

@Data
public class PolicyDto extends BaseDto {

    private PolicyType policyType;
    @NotEmpty(message = "내용을 입력하세요.")
    private String contents;
    @NotNull(message = "버전을 입력하세요.")
    private Integer version;

    @Data
    @Builder
    public static class ApiListItem extends BaseDto {
        private String termsName;
        private String content;
        private Boolean isRequiredCheck;
    }

    @Data
    public static class ListItem extends BaseDto {
        private PolicyType policyType;
        private String contents;
        private Integer version;
    }
}
