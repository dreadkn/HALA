package com.inpply.web.project.admin.dashboard.repository;


import com.inpply.global.repository.Querydsl4RepositorySupport;
import com.inpply.web.common.visit.model.Visit;
import com.inpply.web.global.model.Search;
import com.inpply.web.global.util.DateTimeUtils;
import com.inpply.web.project.admin.dashboard.dto.VisitDto;
import com.querydsl.core.types.ConstantImpl;
import com.querydsl.core.types.Projections;
import com.querydsl.core.types.dsl.Expressions;
import com.querydsl.core.types.dsl.StringTemplate;
import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.stereotype.Repository;

import java.util.List;

import static com.inpply.web.common.visit.model.QVisit.visit;

@Repository
public class VisitQueryRepository extends Querydsl4RepositorySupport {

    public VisitQueryRepository() {
        super(Visit.class);
    }

    public List<VisitDto> findByConnectionStats(Search search) {

        StringTemplate createdDate = Expressions.stringTemplate(
                "DATE_FORMAT({0}, {1})"
                , visit.createdDate
                , ConstantImpl.create("%Y-%m-%d"));

        JPAQuery<VisitDto> query = select(Projections.fields(VisitDto.class,
                createdDate.as("createdDate"),
                visit.ip
        ))
                .from(visit)
                .where(createdDate.between(DateTimeUtils.localDateToString(search.getStartDate()), DateTimeUtils.localDateToString(search.getEndDate())))
                .groupBy(createdDate)
                .orderBy(createdDate.asc());

        return query.fetch();
    }

}
