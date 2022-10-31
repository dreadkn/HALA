package com.inpply.web.project.admin.alarm.service;

import com.inpply.common.domain.entity.Alarm;
import com.inpply.common.domain.repository.AlarmRepository;
import com.inpply.common.domain.user.model.User;
import com.inpply.web.common.user.repository.UserRepository;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.project.admin.alarm.dto.AlarmDto;
import com.inpply.web.security.AuthenticatedUser;
import com.inpply.web.security.AuthenticationHelper;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@Transactional
public class AlarmService {

    private final AlarmRepository alarmRepository;
    private final UserRepository userRepository;
    private final ModelMapper modelMapper;

    public void send(AlarmDto alarmDto)
    {
        User user = getUser();

        alarmDto.setSender(user.getName());
        alarmDto.setSendDate(LocalDateTime.now());

        switch (alarmDto.getAlarmType())
        {
            case FCM:
                sendByFcm(alarmDto);
                break;
            case EMAIL:
                sendByEmail(alarmDto);
                break;
        }

        this.save(alarmDto);
    }

    /**
     * todo : fcm send
     */
    protected void sendByFcm(AlarmDto alarmDto)
    {

    }

    /**
     * todo : email send
     */
    protected void sendByEmail(AlarmDto alarmDto)
    {

    }

    public Long save(AlarmDto alarmDto)
    {
        Alarm result = alarmRepository.save(modelMapper.map(alarmDto, Alarm.class));
        return result.getId();
    }

    public Long update(Long id, AlarmDto alarmDto)
    {
        Alarm alarm = getItem(alarmDto.getId());

        return alarm.getId();
    }

    public void delete(Long id)
    {
        alarmRepository.deleteById(id);
    }

    public AlarmDto getDto(Long id)
    {
        Alarm alarm = getItem(id);
        return modelMapper.map(alarm, AlarmDto.class);
    }

    protected Alarm getItem(Long id)
    {
        Alarm alarm = alarmRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("alarm", "alarmId", id));
        return alarm;
    }

    protected User getUser()
    {
        User user = userRepository.findById(AuthenticationHelper.getId().orElseGet(() -> 0l))
                .orElseThrow(() -> new EntityNotFoundException("user", "userId", "login"));

        return user;
    }

}
