package com.inpply.web.project.admin.calc.month.repository;


import com.inpply.common.domain.entity.CalcMonth;
import com.inpply.global.repository.Querydsl4RepositorySupport;
import com.inpply.web.global.model.Search;
import com.inpply.web.module.banner.model.Banner;
import com.inpply.web.project.admin.calc.month.dto.CalcMonthDto;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import static com.inpply.common.domain.entity.QCalcMonth.calcMonth;
import static com.inpply.web.module.banner.model.QBanner.banner;

@Repository
public class CalcMonthQueryRepository extends Querydsl4RepositorySupport {

    public CalcMonthQueryRepository() {
        super(CalcMonth.class);
    }

    public Page<CalcMonthDto> findAll(Pageable pageable, Search search) {

        JPAQuery<CalcMonthDto> query =
                select(Projections.fields(CalcMonthDto.class,
                        calcMonth.id,
                        calcMonth.calcDate,
                        calcMonth.contentCount,
                        calcMonth.contentAmount,
                        calcMonth.adCount,
                        calcMonth.adAmount,
                        calcMonth.subscribeCount,
                        calcMonth.subscribeAmount,
                        calcMonth.totalAmount
                ))
                .from(calcMonth);

        if (StringUtils.hasText(search.getKeyword())) {
            query.where(banner.url.containsIgnoreCase(search.getKeyword())
                .or(banner.content.containsIgnoreCase(search.getKeyword())));
        }

        return applyPagination(pageable, query);
    }

}
