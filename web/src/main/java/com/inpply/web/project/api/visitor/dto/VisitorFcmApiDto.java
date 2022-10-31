package com.inpply.web.project.api.visitor.dto;

import lombok.Data;

import javax.persistence.Column;

@Data
public class VisitorFcmApiDto {


    @Data
    public static class Register {

        /**사용자*/
        private String visitorToken;

        /**FCM토큰*/
        private String fcmToken;

    }

    @Data
    public static class Info {

        long id;
        /**사용자*/
        private String visitorToken;

        /**FCM토큰*/
        private String fcmToken;

        /**FCM토큰 상태*/
        @Column
        private String fcmTokenStatus;

    }

}
