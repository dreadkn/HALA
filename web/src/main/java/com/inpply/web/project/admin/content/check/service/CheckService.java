package com.inpply.web.project.admin.content.check.service;

import com.inpply.common.domain.entity.*;
import com.inpply.common.domain.repository.*;
import com.inpply.common.domain.type.ContentType;
import com.inpply.common.domain.type.InspectionStatus;
import com.inpply.common.domain.type.PaymentStatus;
import com.inpply.common.domain.user.model.User;
import com.inpply.web.common.user.repository.UserRepository;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.project.admin.content.check.dto.CheckDto;
import com.inpply.web.project.admin.content.check.repository.CheckQueryRepository;
import com.inpply.web.project.admin.content.news.repository.NewsQueryRepository;
import com.inpply.web.project.admin.content.news.service.NewsService;
import com.inpply.web.security.AuthenticationHelper;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class CheckService {

    private final ContentCheckRepository contentCheckRepository;
    private final CheckQueryRepository checkQueryRepository;
    private final ModelMapper modelMapper;
    private final UserRepository userRepository;

    private final NewsRepository newsRepository;
    private final EventRepository eventRepository;
    private final CongratulationsRepository congratulationsRepository;
    private final HumanRepository humanRepository;

    public void add(ContentType contentType, Long id)
    {
        Optional<ContentCheck> existCheck = contentCheckRepository.findByContentTypeAndContentId(contentType, id);

        if (!existCheck.isPresent())
        {
            ContentCheck contentCheck = ContentCheck.builder()
                    .contentId(id)
                    .contentType(contentType)
                    .payment(Payment.builder()
                            .paymentStatus(PaymentStatus.COMPLETE)
                            .build())
                    .inspection(Inspection.builder()
                            .inspectionStatus(InspectionStatus.WAIT)
                            .build())
                    .build();

            contentCheckRepository.save(contentCheck);
        }
    }

    public Long save(CheckDto.Request contentCheckDto)
    {
        ContentCheck result = contentCheckRepository.save(modelMapper.map(contentCheckDto, ContentCheck.class));
        return result.getId();
    }

    public Long update(Long id, CheckDto.Request contentCheckDto)
    {
        ContentCheck contentCheck = getItem(contentCheckDto.getId());

        Payment payment = modelMapper.map(contentCheckDto.getPayment(), Payment.class);
        Inspection inspection = modelMapper.map(contentCheckDto.getInspection(), Inspection.class);

        inspection.setInspectionUser(getUser());

        contentCheck.change(payment, inspection);

        checkInspection(contentCheckDto);

        return contentCheck.getId();
    }

    public void delete(Long id)
    {
        contentCheckRepository.deleteById(id);
    }

    public CheckDto getDto(Long id)
    {
        return checkQueryRepository.findById(id);
    }

    protected ContentCheck getItem(Long id)
    {
        ContentCheck contentCheck = contentCheckRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("contentCheck", "contentCheckId", id));
        return contentCheck;
    }

    protected User getUser()
    {
        User user = userRepository.findById(AuthenticationHelper.getId().orElseGet(() -> 0l))
                .orElseThrow(() -> new EntityNotFoundException("user", "user", "login"));
        return user;
    }

    protected News getNews(Long id)
    {
        News news = newsRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("news", "newsId", id));
        return news;
    }

    protected Event getEvent(Long id)
    {
        Event event = eventRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("evnet", "eventId", id));
        return event;
    }

    protected Congratulations getCongratulations(Long id)
    {
        Congratulations congratulations = congratulationsRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("congratulations", "congratulationsId", id));
        return congratulations;
    }

    protected Human getHuman(Long id)
    {
        Human human = humanRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("human", "humanId", id));
        return human;
    }

    protected void checkInspection(CheckDto.Request contentCheckDto)
    {
        switch (contentCheckDto.getInspection().getInspectionStatus())
        {
            case WAIT:
            case INSPECTION:
            case REJECT:
                reject(contentCheckDto);
                break;
            case APPROVE:
                approve(contentCheckDto);
                break;
        }
    }

    protected void approve(CheckDto.Request contentCheckDto)
    {
        switch (contentCheckDto.getContentType())
        {
            case NEWS:
                getNews(contentCheckDto.getContentId()).approve();
                break;
            case EVENT:
                getEvent(contentCheckDto.getContentId()).approve();
                break;
            case CONGRATULATIONS:
                getCongratulations(contentCheckDto.getContentId()).approve();
                break;
            case HUMAN:
                getHuman(contentCheckDto.getContentId()).approve();
                break;
        }
    }

    protected void reject(CheckDto.Request contentCheckDto)
    {
        switch (contentCheckDto.getContentType())
        {
            case NEWS:
                getNews(contentCheckDto.getContentId()).reject();;
                break;
            case EVENT:
                getEvent(contentCheckDto.getContentId()).reject();
                break;
            case CONGRATULATIONS:
                getCongratulations(contentCheckDto.getContentId()).reject();
                break;
            case HUMAN:
                getHuman(contentCheckDto.getContentId()).reject();
                break;
        }
    }

}
