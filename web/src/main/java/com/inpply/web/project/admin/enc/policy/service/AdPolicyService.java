package com.inpply.web.project.admin.enc.policy.service;

import com.inpply.common.domain.entity.AdPolicy;
import com.inpply.common.domain.repository.AdPolicyRepository;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.project.admin.enc.policy.dto.AdPolicyDto;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class AdPolicyService {

    private final AdPolicyRepository adPolicyRepository;
    private final ModelMapper modelMapper;

    public Long save(AdPolicyDto adAdPolicyDto)
    {
        AdPolicy result = adPolicyRepository.save(modelMapper.map(adAdPolicyDto, AdPolicy.class));
        return result.getId();
    }

    public Long update(Long id, AdPolicyDto adAdPolicyDto)
    {
        AdPolicy adPolicy = getItem(id);

        adPolicy.change(adAdPolicyDto.getStartDate(), adAdPolicyDto.getEndDate(), adAdPolicyDto.getPeriodType(), adAdPolicyDto.getAdType(), adAdPolicyDto.getPrice());

        return adPolicy.getId();
    }

    public void delete(Long id)
    {
        adPolicyRepository.deleteById(id);
    }

    public AdPolicyDto getDto(Long id)
    {
        AdPolicy adPolicy = getItem(id);
        return modelMapper.map(adPolicy, AdPolicyDto.class);
    }

    protected AdPolicy getItem(Long id)
    {
        AdPolicy adPolicy = adPolicyRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("adPolicy", "adPolicyId", id));
        return adPolicy;
    }

}
