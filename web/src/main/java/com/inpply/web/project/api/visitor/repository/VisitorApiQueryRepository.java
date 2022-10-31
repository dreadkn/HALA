package com.inpply.web.project.api.visitor.repository;


import com.inpply.common.domain.entity.Visitor;
import com.inpply.global.repository.Querydsl4RepositorySupport;
import com.inpply.web.project.api.visitor.dto.VisitorSearchApiDto;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.stereotype.Repository;

import java.util.List;

import static com.inpply.common.domain.entity.QVisitor.visitor;
import static com.inpply.common.domain.entity.QVisitorSearch.visitorSearch;


@Repository
public class VisitorApiQueryRepository extends Querydsl4RepositorySupport {

    public VisitorApiQueryRepository() {
        super(Visitor.class);
    }

    public List<VisitorSearchApiDto.List> findKeywordList(String visitorToken) {
        JPAQuery<VisitorSearchApiDto.List> query =
                select(Projections.fields(VisitorSearchApiDto.List.class,
                        visitorSearch.keyword
                    )
                )

                .from(visitorSearch)
                .leftJoin(visitor).on(visitor.visitorToken.eq(visitorToken))
                .where(visitorSearch.visitor.eq(visitor))
                .groupBy(visitorSearch.keyword)
//                .orderBy(visitorSearch.createdDate.desc())
                        .limit(30);


        return query.fetch();
    }
}
