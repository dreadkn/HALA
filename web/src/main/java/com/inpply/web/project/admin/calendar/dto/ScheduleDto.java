package com.inpply.web.project.admin.calendar.dto;

import com.inpply.common.domain.calendar.model.Schedule;
import com.inpply.common.domain.pdf.model.MakePdf;
import com.inpply.global.converter.BooleanAttributeConverter;
import com.inpply.web.common.file.dto.FileDto;
import com.inpply.web.global.dto.BaseDto;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import javax.persistence.Column;
import javax.persistence.Convert;
import java.time.LocalDateTime;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class ScheduleDto extends BaseDto {

    private Long id;
    private String name;
    private String color;
    private Boolean timed;
    private LocalDateTime start;
    private LocalDateTime end;

    public ScheduleDto(Schedule schedule) {
        this.id = schedule.getId();
        this.name = schedule.getName();
        this.color = schedule.getColor();
        this.timed = schedule.getTimed();
        this.start = schedule.getStart();
        this.end = schedule.getEnd();
    }

    public Schedule toEntity() {
        return Schedule.builder()
                .name(this.name)
                .color(this.color)
                .timed(this.timed)
                .start(this.start)
                .end(this.end)
                .build();
    }
}
