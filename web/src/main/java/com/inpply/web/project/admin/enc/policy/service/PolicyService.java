package com.inpply.web.project.admin.enc.policy.service;

import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.module.banner.model.Banner;
import com.inpply.web.module.banner.repository.BannerRepository;
import com.inpply.web.project.admin.enc.policy.dto.PolicyDto;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class PolicyService {

    private final BannerRepository bannerRepository;
    private final ModelMapper modelMapper;

    public Long save(PolicyDto bannerDto)
    {
        Banner result = bannerRepository.save(modelMapper.map(bannerDto, Banner.class));
        return result.getId();
    }

    public Long update(Long id, PolicyDto bannerDto)
    {
        Banner banner = getItem(bannerDto.getId());

        return banner.getId();
    }

    public void delete(Long id)
    {
        bannerRepository.deleteById(id);
    }

    public PolicyDto getDto(Long id)
    {
        Banner banner = bannerRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("banner", "bannerId", id));
        return modelMapper.map(banner, PolicyDto.class);
    }

    protected Banner getItem(Long id)
    {
        Banner banner = bannerRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("banner", "bannerId", id));
        return banner;
    }

}
