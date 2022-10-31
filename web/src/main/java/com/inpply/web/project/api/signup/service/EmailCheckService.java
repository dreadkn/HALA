package com.inpply.web.project.api.signup.service;

import com.inpply.common.domain.entity.Member;
import com.inpply.web.infra.mail.event.PasswordResetEvent;
import com.inpply.web.project.api.common.dto.ResultDto;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.concurrent.ThreadLocalRandom;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class EmailCheckService {

    private final ModelMapper modelMapper;
    private final ApplicationEventPublisher eventPublisher;

    @Transactional
    public ResultDto.Result sendFindPasswordEmail(Member member, ResultDto.Result result) {

        // 이메일 발송
        eventPublisher.publishEvent(new PasswordResetEvent(member.getUserId(), member.getEmail(), member.getName(), result.getReserve1()));

        result.setSuccess(1l);
        return result;
    }
}
