package com.inpply.web.project.admin.content.event.service;

import com.inpply.common.domain.entity.Event;
import com.inpply.common.domain.repository.EventRepository;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.project.admin.content.event.dto.EventDto;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class EventService {

    private final EventRepository eventRepository;
    private final ModelMapper modelMapper;

    public Long save(EventDto eventDto)
    {
        Event result = eventRepository.save(modelMapper.map(eventDto, Event.class));
        return result.getId();
    }

    public Long update(Long id, EventDto eventDto)
    {
        Event event = getItem(eventDto.getId());

        event.change(eventDto.getIsPublic(),eventDto.getTitle(), eventDto.getContent(), eventDto.getHomepageUrl(), eventDto.getYoutubeUrl(), eventDto.getFiles());

        return event.getId();
    }

    public void delete(Long id)
    {
        Event event = getItem(id);
        event.delete();
        
    }

    public EventDto getDto(Long id)
    {
        Event Event = eventRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Event", "EventId", id));
        return modelMapper.map(Event, EventDto.class);
    }

    protected Event getItem(Long id)
    {
        Event Event = eventRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Event", "EventId", id));
        return Event;
    }

}
