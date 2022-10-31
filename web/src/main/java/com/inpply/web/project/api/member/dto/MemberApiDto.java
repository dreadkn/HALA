package com.inpply.web.project.api.member.dto;

import com.inpply.common.converter.BooleanToYNConverter;
import com.inpply.common.domain.entity.Member;
import com.inpply.common.domain.file.model.File;
import com.inpply.web.common.file.dto.FileDto;
import com.inpply.web.global.dto.BaseDto;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Convert;
import java.util.ArrayList;
import java.util.List;

@Data
public class MemberApiDto extends BaseDto {


    @Data
    public static class RequestDto extends BaseDto {

        private Long id;
        String userId;
        String name;
        String nickname;
        String phone;
        String email;

        /**일반 알림 수신여부*/
        Boolean isReceiveAlarmNormal;

        /**마케팅 알림 수신여부*/
        Boolean isReceiveAlarmMarketing;

    }

    @Data
    public static class UpdateDto extends BaseDto {

        String phone;

        /**푸시 허용여부*/
        Boolean isAgreePush;

        /**이메일 허용여부*/
        Boolean isAgreeEmail;


    }

    @Data
    public static class ChangePwDto extends BaseDto {

        String password;
        String passwordNew;
        String passwordConfirm;
    }

    @Data
    public static class DetailDto {
        private Long id;
        String userId;
        String name;
        String phone;
        String email;
        /**콘텐츠 등록수량*/
        Integer contentCount;
        /**광고 등록수량 */
        Integer adCount;
        /**구독여부*/
        Boolean isSubscribe;


        /**푸시 허용여부*/
        Boolean isAgreePush;

        /**이메일 허용여부*/
        Boolean isAgreeEmail;


        public DetailDto(Member member) {
            this.id = member.getId();
            this.userId = member.getUserId();
            this.name = member.getName();
            this.phone = member.getPhone();
            this.email = member.getEmail();
            this.contentCount = member.getContentCount();
            this.adCount = member.getAdCount();
            this.isSubscribe = member.getIsSubscribe();
            this.isAgreePush = member.getIsAgreePush();
            this.isAgreeEmail = member.getIsAgreeEmail();

        }
    }


}
