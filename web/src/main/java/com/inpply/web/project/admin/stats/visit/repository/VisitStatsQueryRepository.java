package com.inpply.web.project.admin.stats.visit.repository;


import com.inpply.global.repository.Querydsl4RepositorySupport;
import com.inpply.web.global.model.Search;
import com.inpply.web.module.banner.model.Banner;
import com.inpply.web.project.admin.stats.visit.dto.VisitStatsDto;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import static com.inpply.web.module.banner.model.QBanner.banner;

@Repository
public class VisitStatsQueryRepository extends Querydsl4RepositorySupport {

    public VisitStatsQueryRepository() {
        super(Banner.class);
    }

    public Page<VisitStatsDto> findAll(Pageable pageable, Search search) {

        JPAQuery<VisitStatsDto> query =
                select(Projections.fields(VisitStatsDto.class,
                        banner.id
                ))
                .from(banner);

        if (StringUtils.hasText(search.getKeyword())) {
            query.where(banner.url.containsIgnoreCase(search.getKeyword())
                .or(banner.content.containsIgnoreCase(search.getKeyword())));
        }

        return applyPagination(pageable, query);
    }

}
