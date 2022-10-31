package com.inpply.web.project.admin.content.wedding.service;

import com.inpply.common.domain.entity.Congratulations;
import com.inpply.common.domain.entity.Death;
import com.inpply.common.domain.entity.Person;
import com.inpply.common.domain.entity.Wedding;
import com.inpply.common.domain.repository.CongratulationsRepository;
import com.inpply.common.domain.repository.DeathRepository;
import com.inpply.common.domain.repository.PersonRepository;
import com.inpply.common.domain.repository.WeddingRepository;
import com.inpply.common.domain.user.model.User;
import com.inpply.web.common.user.repository.UserRepository;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.project.admin.content.wedding.dto.WeddingDto;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class WeddingService {

    private final WeddingRepository weddingRepository;
    private final DeathRepository deathRepository;
    private final PersonRepository personRepository;
    private final CongratulationsRepository congratulationsRepository;
    private final UserRepository userRepository;
    private final ModelMapper modelMapper;

    public Long save(WeddingDto weddingDto)
    {
        Congratulations result = null;
        switch (weddingDto.getDtype())
        {
            case WEDDING:
                result = weddingRepository.save(modelMapper.map(weddingDto, Wedding.class));
                break;
            case DEATH:
                result = deathRepository.save(modelMapper.map(weddingDto, Death.class));
                break;
            case PERSON:
                result = personRepository.save(modelMapper.map(weddingDto, Person.class));
                break;
        }

        return result.getId();
    }

    public Long update(Long id, WeddingDto weddingDto)
    {
        Congratulations congratulations = getItem(id);

        switch (weddingDto.getDtype())
        {
            case WEDDING:
                Wedding wedding = (Wedding) congratulations;
                wedding.change(weddingDto.getIsPublic(), weddingDto.getTitle(), weddingDto.getHomepageUrl(), weddingDto.getYoutubeUrl(), weddingDto.getReadCount(), weddingDto.getFiles(), weddingDto.getGroom(),weddingDto.getGroomFather(), weddingDto.getGroomMother(), weddingDto.getBride(), weddingDto.getBrideFather(), weddingDto.getBrideMother(),
                        weddingDto.getWeddingDate(), weddingDto.getPlace(), weddingDto.getPartyDate(), weddingDto.getPartyPlace(), weddingDto.getGroomJob(), weddingDto.getBrideJob());
                break;
            case DEATH:
                Death death = (Death) congratulations;
                death.change(weddingDto.getIsPublic(), weddingDto.getTitle(), weddingDto.getHomepageUrl(), weddingDto.getYoutubeUrl(), weddingDto.getReadCount(), weddingDto.getFiles(),
                        weddingDto.getIllpho(), weddingDto.getOutDate(), weddingDto.getPlace(), weddingDto.getCemetery(), weddingDto.getContent(), weddingDto.getDeceased(), weddingDto.getDeceasedJob());
                break;
            case PERSON:
                Person person = (Person) congratulations;
                person.change(weddingDto.getIsPublic(), weddingDto.getTitle(), weddingDto.getHomepageUrl(), weddingDto.getYoutubeUrl(), weddingDto.getReadCount(), weddingDto.getFiles(),
                        weddingDto.getContent());
                break;
        }

        return congratulations.getId();
    }

    public void delete(Long id)
    {
        Congratulations congratulations = getItem(id);
        congratulations.delete();
    }

    public WeddingDto getDto(Long id)
    {
        WeddingDto weddingDto = modelMapper.map(getItem(id), WeddingDto.class);
        weddingDto.setCreatedName(getUser(weddingDto.getCreatedBy()).getName());

        return weddingDto;
    }

    protected Congratulations getItem(Long id)
    {
        Congratulations congratulations = congratulationsRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Wedding", "WeddingId", id));
        return congratulations;
    }

    protected User getUser(Long id)
    {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("user", "userId", id));
        return user;
    }

}
