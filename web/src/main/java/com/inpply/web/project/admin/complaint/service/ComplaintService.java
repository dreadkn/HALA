package com.inpply.web.project.admin.complaint.service;

import com.inpply.common.domain.entity.Broken;
import com.inpply.common.domain.repository.BrokenRepository;
import com.inpply.common.domain.type.BrokenStatus;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.project.admin.complaint.dto.ComplaintDto;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class ComplaintService {

    private final BrokenRepository brokenRepository;
    private final ModelMapper modelMapper;

    public Long save(ComplaintDto brokenDto)
    {
        Broken broken = modelMapper.map(brokenDto, Broken.class);
        broken.setBrokenStatus(BrokenStatus.WAIT);

        Broken result = brokenRepository.save(broken);
        return result.getId();
    }

    public Long update(Long id, ComplaintDto brokenDto)
    {
        Broken broken = getItem(id);

        return broken.getId();
    }

    public Long answer(Long id, ComplaintDto brokenDto)
    {
        Broken broken = getItem(id);

        broken.anwser(brokenDto.getBrokenStatus(), brokenDto.getAnswer());

        return broken.getId();
    }

    public void delete(Long id)
    {
        brokenRepository.deleteById(id);
    }

    public ComplaintDto getDto(Long id)
    {
        Broken broken = getItem(id);
        return modelMapper.map(broken, ComplaintDto.class);
    }

    protected Broken getItem(Long id)
    {
        Broken broken = brokenRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("broken", "brokenId", id));
        return broken;
    }

}
