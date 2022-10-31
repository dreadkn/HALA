package com.inpply.web.project.admin.stats.dto;

import com.inpply.web.global.dto.BaseDto;
import lombok.Data;

import java.math.BigDecimal;
import java.math.BigInteger;

@Data
public class StatsDto  {

    private String createdDate;
    private BigInteger cnt;
    private BigDecimal amount;
}
