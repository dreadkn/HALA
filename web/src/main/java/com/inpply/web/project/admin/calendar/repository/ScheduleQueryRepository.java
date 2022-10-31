package com.inpply.web.project.admin.calendar.repository;

import com.inpply.common.domain.calendar.model.Schedule;
import com.inpply.global.repository.Querydsl4RepositorySupport;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.calendar.dto.ScheduleDto;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import static com.inpply.common.domain.calendar.model.QSchedule.schedule;

@Repository
public class ScheduleQueryRepository extends Querydsl4RepositorySupport {

    public ScheduleQueryRepository() {
        super(Schedule.class);
    }

    public List<ScheduleDto> findAll(Search search) {

        JPAQuery<ScheduleDto> query =
                select(Projections.fields(ScheduleDto.class,
                        schedule.id,
                        schedule.name,
                        schedule.color,
                        schedule.timed,
                        schedule.start,
                        schedule.end)
                )
                .from(schedule)
                .where(schedule.start.between(
                        LocalDateTime.of(search.getStartDate(), LocalTime.MIN),
                        LocalDateTime.of(search.getEndDate(), LocalTime.MAX)));

        return query.fetch();
    }

}
