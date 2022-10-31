package com.inpply.web.project.admin.enc.policy.service;

import com.inpply.common.domain.entity.SubscribePolicy;
import com.inpply.common.domain.repository.SubscribePolicyRepository;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.project.admin.enc.policy.dto.PolicyDto;
import com.inpply.web.project.admin.enc.policy.dto.SubscribePolicyDto;
import com.inpply.web.project.admin.subscribe.repository.SubscribeQueryRepository;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class SubscribePolicyService {

    private final SubscribePolicyRepository subscribePolicyRepository;
    private final ModelMapper modelMapper;

    public Long save(SubscribePolicyDto subscribePolicyDto)
    {
        SubscribePolicy result = subscribePolicyRepository.save(modelMapper.map(subscribePolicyDto, SubscribePolicy.class));
        return result.getId();
    }

    public Long update(Long id, SubscribePolicyDto subscribePolicyDto)
    {
        SubscribePolicy subscribePolicy = getItem(id);

        subscribePolicy.change(subscribePolicyDto.getStartDate(), subscribePolicyDto.getEndDate(),
                subscribePolicyDto.getPeriodType(), subscribePolicyDto.getContentCount(),
                subscribePolicyDto.getAdCount(), subscribePolicyDto.getPrice());

        return subscribePolicy.getId();
    }

    public void delete(Long id)
    {
        subscribePolicyRepository.deleteById(id);
    }

    public SubscribePolicyDto getDto(Long id)
    {
        SubscribePolicy subscribePolicy = getItem(id);
        return modelMapper.map(subscribePolicy, SubscribePolicyDto.class);
    }

    protected SubscribePolicy getItem(Long id)
    {
        SubscribePolicy subscribePolicy = subscribePolicyRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("subscribePolicy", "subscribePolicyId", id));
        return subscribePolicy;
    }

}
