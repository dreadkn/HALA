package com.inpply.web.global.model;

import com.inpply.web.module.banner.type.BannerType;
import com.inpply.web.module.sms.type.SmsStatus;
import com.inpply.web.module.sms.type.SmsType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Search {

    private String searchType;
    private String keyword = "";

    private Boolean enabled;
    @DateTimeFormat(iso = ISO.DATE)
    private LocalDate startDate;
    @DateTimeFormat(iso = ISO.DATE)
    private LocalDate endDate;
    @DateTimeFormat(iso = ISO.DATE)
    private LocalDate startDate2;
    @DateTimeFormat(iso = ISO.DATE)
    private LocalDate endDate2;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime startDateTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime endDatetime;

    //Board
    private String manufactureCode;
    private Boolean isConnection;
    private Long trusterId;
    private Boolean isRegisteredPayCard;

    private Boolean isStop;
    private String bid;
    private DateClass dateClass = DateClass.DAY;
    private boolean ownCharger = true;
    private Boolean isCalculated;

    private String year;
    private String month;

    private Integer size;
    private Long page;



    public boolean equalsSearchType(String... searchType) {
        return Arrays.stream(searchType).anyMatch(s -> s.equalsIgnoreCase(this.searchType));
    }


    public enum DateClass {
        DAY, WEEK, MONTH
    }
}
