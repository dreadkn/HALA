package com.inpply.web.project.admin.enc.version.service;

import com.inpply.common.domain.entity.AppVersion;
import com.inpply.common.domain.repository.AppVersionRepository;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.project.admin.enc.version.dto.VersionDto;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class VersionService {

    private final AppVersionRepository appVersionRepository;
    private final ModelMapper modelMapper;

    public Long save(VersionDto appVersionDto)
    {
        AppVersion result = appVersionRepository.save(modelMapper.map(appVersionDto, AppVersion.class));
        return result.getId();
    }

    public Long update(Long id, VersionDto appVersionDto)
    {
        AppVersion appVersion = getItem(id);

        appVersion.change(appVersionDto.getAppType(), appVersionDto.getVersion(), appVersionDto.getIsEssentialUpdate());

        return appVersion.getId();
    }

    public void delete(Long id)
    {
        appVersionRepository.deleteById(id);
    }

    public VersionDto getDto(Long id)
    {
        AppVersion appVersion = getItem(id);
        return modelMapper.map(appVersion, VersionDto.class);
    }

    protected AppVersion getItem(Long id)
    {
        AppVersion appVersion = appVersionRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("appVersion", "appVersionId", id));
        return appVersion;
    }

}
