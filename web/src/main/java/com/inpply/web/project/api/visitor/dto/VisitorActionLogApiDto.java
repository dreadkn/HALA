package com.inpply.web.project.api.visitor.dto;

import com.inpply.common.domain.type.ActionLogType;
import com.inpply.common.domain.type.ContentType;
import lombok.Data;

@Data
public class VisitorActionLogApiDto {

    @Data
    public static class Register {
        /**사용자*/
        private String visitorToken;

        /**액션*/
        private ActionLogType actionLogType;

        ContentType contentType;

        Long targetId;
        String searchText;
        private double lat;
        private double lng;
        /**지역*/
        String areaCode;
        private String area1;
        private String area2;
        private String area3;
    }


}
