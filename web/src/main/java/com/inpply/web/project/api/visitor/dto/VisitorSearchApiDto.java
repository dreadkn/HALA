package com.inpply.web.project.api.visitor.dto;

import lombok.Data;

@Data
public class VisitorSearchApiDto {

    @Data
    public static class List {
        private String keyword;
    }

}
