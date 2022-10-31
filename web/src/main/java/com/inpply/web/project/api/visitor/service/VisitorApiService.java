package com.inpply.web.project.api.visitor.service;

import com.inpply.common.domain.entity.Visitor;
import com.inpply.common.domain.entity.VisitorActionLog;
import com.inpply.common.domain.entity.VisitorFcm;
import com.inpply.common.domain.repository.VisitorActionLogRepository;
import com.inpply.common.domain.repository.VisitorFcmRepository;
import com.inpply.common.domain.repository.VisitorRepository;
import com.inpply.common.domain.repository.VisitorSearchRepository;
import com.inpply.common.domain.type.ActionLogType;
import com.inpply.common.domain.type.ContentType;
import com.inpply.web.project.api.common.dto.ResultDto;
import com.inpply.web.project.api.visitor.dto.*;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class VisitorApiService {

    private final VisitorRepository visitorRepository;
    private final VisitorFcmRepository visitorFcmRepository;
    private final VisitorSearchRepository visitorSearchRepository;
    private final VisitorActionLogRepository visitorActionLogRepository;
    private final ApplicationEventPublisher eventPublisher;


    @Transactional
    public VisitorApiDto.Result registerVisitor() {
        String visitorToken = UUID.randomUUID().toString();

        while (visitorRepository.countByVisitorToken(visitorToken) != 0) {
            visitorToken = UUID.randomUUID().toString();
        }

        Visitor visitor = Visitor.builder()
                .visitorToken(visitorToken)
                .isSearchCompany(false)
                .isSearchPlug(false)
                .lastDt(LocalDateTime.now())
                .build();

        visitorRepository.save(visitor);

        VisitorApiDto.Result result = new VisitorApiDto.Result();
        result.setVisitorToken(visitorToken);
        result.setId(visitor.getId());

        return result;
    }

    @Transactional
    public ResultDto.Result registerFcm(VisitorFcmApiDto.Register register) {
        ResultDto.Result result = new ResultDto.Result();
        try {
            Visitor visitor = visitorRepository.findByVisitorToken(register.getVisitorToken()).orElse(null);
            if (visitor == null)
                result.setFailCode("VISITOR_NOT_REGISTER");
            else if (register.getFcmToken() == null || register.getVisitorToken().length() == 0)
                result.setFailCode("FCM_TOKEN_VALIDATE");
            else {

                VisitorFcm visitorFcm = visitorFcmRepository.findByVisitor(visitor).orElse(null);
                if (visitorFcm == null) {
                    visitorFcm = VisitorFcm.builder()
                            .visitor(visitor)
                            .fcmToken(register.getFcmToken())
                            .build();
                } else {
                    visitorFcm.setFcmToken(register.getFcmToken());
                }

                visitorFcmRepository.save(visitorFcm);
                result.setSuccess(visitorFcm.getId());
            }
        } catch (Exception e) {
            result.setFail("실패하였습니다.");
        }

        return result;
    }

    @Transactional
    public ResultDto.Result registerActionLog(VisitorActionLogApiDto.Register register) {
        ResultDto.Result result = new ResultDto.Result();
        try {
            Visitor visitor = visitorRepository.findByVisitorToken(register.getVisitorToken()).orElse(null);

            if (visitor == null)
                result.setFailCode("VISITOR_NOT_REGISTER");
            else {



                VisitorActionLog visitorActionLog = VisitorActionLog.builder()
                        .visitorId(visitor.getId())
                        .actionLogType(register.getActionLogType())
                        .contentType(register.getContentType())
                        .targetId(register.getTargetId())
                        .searchText(register.getSearchText())
                        .build();

                visitorActionLogRepository.save(visitorActionLog);
                result.setSuccess(visitorActionLog.getId());
            }
        } catch (Exception e) {
            result.setFail("실패하였습니다.");
        }

        return result;

    }

    @Transactional
    public boolean registerContentLog(Visitor visitor, ContentType contentType, Long targetId) {
        try {

            VisitorActionLog log = VisitorActionLog.builder()
                    .actionLogType(ActionLogType.SEARCH)
                    .contentType(contentType)
                    .visitorId(visitor.getId())
                    .targetId(targetId)
                    .build();
            visitorActionLogRepository.save(log);
            return true;

        } catch (Exception e) {}
        return false;
    }
}
