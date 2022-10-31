package com.inpply.web.project.admin.content.human.service;

import com.inpply.common.domain.entity.Human;
import com.inpply.common.domain.repository.HumanRepository;
import com.inpply.web.config.InpplyConfigProperties;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.infra.upload.ExcelProcess;
import com.inpply.web.infra.upload.factory.HumanExcelDtoCreators;
import com.inpply.web.project.admin.content.human.dto.HumanDto;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.transaction.Transactional;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class HumanService {

    private final HumanRepository humanRepository;
    private final ModelMapper modelMapper;

    private final ExcelProcess excelProcess;
    private final InpplyConfigProperties inpplyConfigProperties;

    public Long save(HumanDto humanDto)
    {
        Human result = humanRepository.save(modelMapper.map(humanDto, Human.class));
        return result.getId();
    }

    public Long update(Long id, HumanDto humanDto)
    {
        Human human = getItem(id);

        human.change(humanDto.getIsPublic(), humanDto.getKrName(), humanDto.getCnName(), humanDto.getEnName(), humanDto.getPosition(), humanDto.getBirthYear(), humanDto.getAddress(), humanDto.getEmail(), humanDto.getEducation(),
                humanDto.getCareer(), humanDto.getWriting(), humanDto.getPaper(), humanDto.getAwards(), humanDto.getEtc1(), humanDto.getEtc2(), humanDto.getFiles());


        return human.getId();
    }

    public void delete(Long id)
    {
        Human human = getItem(id);
        human.delete();
    }

    public HumanDto getDto(Long id)
    {
        Human human = getItem(id);
        return modelMapper.map(human, HumanDto.class);
    }

    public void uploadExcel(MultipartHttpServletRequest request)
    {
        HashMap<String, Object> map = excelProcess.excelToDto(request, inpplyConfigProperties.getFile().getStorePath(), new HumanExcelDtoCreators());

        List<HumanDto> list = (List<HumanDto>) map.get("list");

        List<Human> humans = list.stream().map(humanDto -> modelMapper.map(humanDto, Human.class)).collect(Collectors.toList());

        humanRepository.saveAll(humans);
    }

    protected Human getItem(Long id)
    {
        Human human = humanRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("human", "humanId", id));
        return human;
    }

}
