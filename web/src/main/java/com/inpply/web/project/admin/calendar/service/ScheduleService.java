package com.inpply.web.project.admin.calendar.service;

import com.inpply.common.domain.calendar.model.Schedule;
import com.inpply.common.domain.calendar.repository.ScheduleRepository;
import com.inpply.web.project.admin.calendar.dto.ScheduleDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@Slf4j
@RequiredArgsConstructor
public class ScheduleService {
	private final ScheduleRepository scheduleRepository;

	public Long saveSchedule(ScheduleDto scheduleDto) {

		Schedule schedule = scheduleDto.toEntity();
		scheduleRepository.save(schedule);
		return schedule.getId();
	}

	public void updateSchedule(ScheduleDto scheduleDto) {
		Schedule schedule = scheduleRepository.getById(scheduleDto.getId());
		schedule.updateSchedule(scheduleDto.getName(), scheduleDto.getColor(), scheduleDto.getTimed(), scheduleDto.getStart(), scheduleDto.getEnd());
	}

	public void deleteSchedule(Long id) {
		Schedule schedule = scheduleRepository.getById(id);
		scheduleRepository.delete(schedule);
	}
}
