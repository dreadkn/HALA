package com.inpply.web.project.admin.alarm.dto;

import com.inpply.common.domain.type.AlarmTarget;
import com.inpply.common.domain.type.AlarmType;
import com.inpply.web.global.dto.BaseDto;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.time.LocalDateTime;

@Data
public class AlarmDto extends BaseDto {

    private AlarmType alarmType;
    private AlarmTarget alarmTarget;
    private String sender;
    private LocalDateTime sendDate;
    @NotBlank(message = "알림명을 입력하세요.")
    private String title;
    @NotBlank(message = "내용을 입력하세요.")
    private String content;
    private Integer receiversCount;

    @Data
    public static class ListItem extends BaseDto {
        private AlarmTarget alarmTarget;
        private String title;
        private String sender;
        private LocalDateTime sendDate;
        private Integer receiversCount;
    }
}
