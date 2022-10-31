package com.inpply.web.project.admin.subscribe.service;

import com.inpply.common.domain.entity.Member;
import com.inpply.common.domain.entity.SubscribeBenefit;
import com.inpply.common.domain.entity.Subscriber;
import com.inpply.common.domain.repository.MemberRepository;
import com.inpply.common.domain.repository.SubscribePolicyRepository;
import com.inpply.common.domain.repository.SubscriberRepository;
import com.inpply.common.domain.type.PaymentStatus;
import com.inpply.common.domain.type.PaymentType;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.project.admin.content.check.dto.CheckDto;
import com.inpply.web.project.admin.enc.policy.dto.SubscribePolicyDto;
import com.inpply.web.project.admin.enc.policy.repository.SubscribePolicyQueryRepository;
import com.inpply.web.project.admin.subscribe.dto.SubscribeDto;
import com.inpply.web.security.AuthenticationHelper;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class SubscribeService {

    private final SubscriberRepository subscriberRepository;
    private final SubscribePolicyQueryRepository subscribePolicyQueryRepository;
    private final MemberRepository memberRepository;
    private final ModelMapper modelMapper;

    public Long subscribe(SubscribeDto.Request subscriberDto)
    {
        subscriberDto.setPayment(getDefaultPaymentDto());

        Subscriber subscriber = modelMapper.map(subscriberDto, Subscriber.class);

        subscriber.setMember(getMember());
        subscriber.getMember().subscribe();

        subscribePolicyQueryRepository.findByToday()
                .ifPresent(subscribePolicyDto -> {
                    subscriber.setSubscribeBenefit(SubscribeBenefit.builder()
                                    .adCount(subscribePolicyDto.getAdCount())
                                    .contentCount(subscribePolicyDto.getContentCount())
                            .build());

                    subscriber.setAdLeftCount(subscribePolicyDto.getAdCount());
                    subscriber.setContentLeftCount(subscribePolicyDto.getContentCount());
                    subscriber.getPayment().setPrice(subscribePolicyDto.getPrice());
                });

        Subscriber result = subscriberRepository.save(subscriber);
        return result.getId();
    }

    public void unsubscribe()
    {
        getMember().unsubscribe();
    }

    public Long update(Long id, SubscribeDto.Request subscriberDto)
    {
        Subscriber subscriber = getItem(id);

        return subscriber.getId();
    }

    public void delete(Long id)
    {
        subscriberRepository.deleteById(id);
    }

    public SubscribeDto getDto(Long id)
    {
        Subscriber subscriber = getItem(id);
        return modelMapper.map(subscriber, SubscribeDto.class);
    }

    protected Subscriber getItem(Long id)
    {
        Subscriber subscriber = subscriberRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("subscriber", "subscriberId", id));
        return subscriber;
    }

    protected Member getMember()
    {
        Member member = memberRepository.findById(AuthenticationHelper.getId().orElseGet(() -> -1l))
                .orElseThrow(() -> new EntityNotFoundException("member", "memberId", -1));
        return member;
    }

    protected CheckDto.PaymentDto getDefaultPaymentDto()
    {
        CheckDto.PaymentDto paymentDto = new CheckDto.PaymentDto();

        paymentDto.setPaymentType(PaymentType.SUBSCRIBE);
        paymentDto.setPaymentStatus(PaymentStatus.WAIT);

        return paymentDto;
    }


}
