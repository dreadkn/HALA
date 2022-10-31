package com.inpply.web.project.api.visitor.dto;

import com.inpply.common.domain.entity.Visitor;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Data
public class VisitorApiDto {

    @Data
    public static class Result {
        long id;
        /**사용자토큰*/
        private String visitorToken;

    }

    @Data
    public static class Register {

        long id;
        /**사용자토큰*/
        private String visitorToken;

        /**회원 연계*/
        Long memberId;

        /**충전소 검색시 플러그 타입 적용여부*/
        Boolean isSearchPlug;

        /**요금 검색시 회원카드 적용여부*/
        Boolean isSearchCompany;
    }
    @Data
    public static class Info {

        long id;
        /**사용자토큰*/
        private String visitorToken;

        /**회원 연계*/
        Long memberId;

        /**마지막 사용일지*/
        LocalDateTime lastDt;


        public Info(Visitor visitor) {
            this.id = visitor.getId();
            this.visitorToken = visitor.getVisitorToken();
            this.memberId = visitor.getMemberId();
        }
    }
}
