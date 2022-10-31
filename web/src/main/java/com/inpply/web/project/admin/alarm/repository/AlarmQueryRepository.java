package com.inpply.web.project.admin.alarm.repository;


import com.inpply.common.domain.entity.Alarm;
import com.inpply.common.domain.type.AlarmType;
import com.inpply.global.repository.Querydsl4RepositorySupport;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.alarm.dto.AlarmDto;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import static com.inpply.common.domain.entity.QAlarm.alarm;

@Repository
public class AlarmQueryRepository extends Querydsl4RepositorySupport {

    public AlarmQueryRepository() {
        super(Alarm.class);
    }

    public Page<AlarmDto.ListItem> findAllByFcm(Pageable pageable, Search search) {

        JPAQuery<AlarmDto.ListItem> query =
                select(Projections.fields(AlarmDto.ListItem.class,
                        alarm.id,
                        alarm.alarmTarget,
                        alarm.title,
                        alarm.sender,
                        alarm.sendDate,
                        alarm.receiversCount
                ))
                .from(alarm)
                        .where(alarm.alarmType.eq(AlarmType.FCM));

        if (StringUtils.hasText(search.getKeyword())) {
            query.where(alarm.title.containsIgnoreCase(search.getKeyword()));
        }

        return applyPagination(pageable, query);
    }

    public Page<AlarmDto.ListItem> findAllByEmail(Pageable pageable, Search search) {

        JPAQuery<AlarmDto.ListItem> query =
                select(Projections.fields(AlarmDto.ListItem.class,
                        alarm.id,
                        alarm.alarmTarget,
                        alarm.title,
                        alarm.sender,
                        alarm.sendDate,
                        alarm.receiversCount
                ))
                        .from(alarm)
                        .where(alarm.alarmType.eq(AlarmType.EMAIL));

        if (StringUtils.hasText(search.getKeyword())) {
            query.where(alarm.title.containsIgnoreCase(search.getKeyword()));
        }

        return applyPagination(pageable, query);
    }

}
