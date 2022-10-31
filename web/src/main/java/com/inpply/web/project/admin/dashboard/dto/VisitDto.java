package com.inpply.web.project.admin.dashboard.dto;

import lombok.Data;
import org.springframework.http.HttpMethod;

import java.math.BigInteger;

@Data
public class VisitDto {

    private Long id;

    private String ip;

    private HttpMethod method;

    private String uri;

    private String referer;

    private Long user;

    private String userName;

    @Data
    public static class Connection {

        private String createdDate;
        private BigInteger visitCnt;
    }

    @Data
    public static class Media {

        private String referer;
        private BigInteger visitCnt;
    }
}
