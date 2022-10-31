package com.inpply.web.project.admin.calc.month.service;

import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.module.banner.model.Banner;
import com.inpply.web.module.banner.repository.BannerRepository;
import com.inpply.web.project.admin.calc.month.dto.CalcMonthDto;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class CalcMonthService {

    private final BannerRepository bannerRepository;
    private final ModelMapper modelMapper;

    public Long save(CalcMonthDto bannerDto)
    {
        Banner result = bannerRepository.save(modelMapper.map(bannerDto, Banner.class));
        return result.getId();
    }

    public Long update(Long id, CalcMonthDto bannerDto)
    {
        Banner banner = getItem(bannerDto.getId());

        return banner.getId();
    }

    public void delete(Long id)
    {
        bannerRepository.deleteById(id);
    }

    public CalcMonthDto getDto(Long id)
    {
        Banner banner = bannerRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("banner", "bannerId", id));
        return modelMapper.map(banner, CalcMonthDto.class);
    }

    protected Banner getItem(Long id)
    {
        Banner banner = bannerRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("banner", "bannerId", id));
        return banner;
    }

}
