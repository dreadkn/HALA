package com.inpply.web.project.admin.enc.policy.service;

import com.inpply.common.domain.entity.ContentPolicy;
import com.inpply.common.domain.repository.ContentPolicyRepository;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.project.admin.enc.policy.dto.ContentPolicyDto;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class ContentPolicyService {

    private final ContentPolicyRepository contentPolicyRepository;
    private final ModelMapper modelMapper;

    public Long save(ContentPolicyDto contentPolicyDto)
    {
        ContentPolicy result = contentPolicyRepository.save(modelMapper.map(contentPolicyDto, ContentPolicy.class));
        return result.getId();
    }

    public Long update(Long id, ContentPolicyDto contentPolicyDto)
    {
        ContentPolicy contentPolicy = getItem(id);

        contentPolicy.change(contentPolicyDto.getStartDate(), contentPolicyDto.getEndDate(), contentPolicyDto.getContentType(), contentPolicyDto.getPrice());

        return contentPolicy.getId();
    }

    public void delete(Long id)
    {
        contentPolicyRepository.deleteById(id);
    }

    public ContentPolicyDto getDto(Long id)
    {
        ContentPolicy contentPolicy = getItem(id);
        return modelMapper.map(contentPolicy, ContentPolicyDto.class);
    }

    protected ContentPolicy getItem(Long id)
    {
        ContentPolicy contentPolicy = contentPolicyRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("contentPolicy", "contentPolicyId", id));
        return contentPolicy;
    }

}
