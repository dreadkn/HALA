package com.inpply.web.project.admin.enc.policy.repository;


import com.inpply.common.domain.entity.SubscribePolicy;
import com.inpply.global.repository.Querydsl4RepositorySupport;
import com.inpply.web.global.model.Search;
import com.inpply.web.module.banner.model.Banner;
import com.inpply.web.project.admin.enc.policy.dto.PolicyDto;
import com.inpply.web.project.admin.enc.policy.dto.SubscribePolicyDto;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.time.LocalDateTime;
import java.util.Optional;

import static com.inpply.common.domain.entity.QSubscribePolicy.subscribePolicy;
import static com.inpply.web.module.banner.model.QBanner.banner;

@Repository
public class SubscribePolicyQueryRepository extends Querydsl4RepositorySupport {

    public SubscribePolicyQueryRepository() {
        super(SubscribePolicy.class);
    }

    public Page<SubscribePolicyDto.ListItem> findAll(Pageable pageable, Search search) {

        JPAQuery<SubscribePolicyDto.ListItem> query =
                select(Projections.fields(SubscribePolicyDto.ListItem.class,
                        subscribePolicy.id,
                        subscribePolicy.startDate,
                        subscribePolicy.endDate,
                        subscribePolicy.periodType,
                        subscribePolicy.contentCount,
                        subscribePolicy.adCount,
                        subscribePolicy.price
                ))
                        .from(subscribePolicy);

        /**
         * todo: period
         */



        return applyPagination(pageable, query);
    }

    public Optional<SubscribePolicyDto> findByToday() {

        JPAQuery<SubscribePolicyDto> query =
                select(Projections.fields(SubscribePolicyDto.class,
                        subscribePolicy.id,
                        subscribePolicy.startDate,
                        subscribePolicy.endDate,
                        subscribePolicy.periodType,
                        subscribePolicy.contentCount,
                        subscribePolicy.adCount,
                        subscribePolicy.price
                ))
                        .from(subscribePolicy).orderBy(subscribePolicy.startDate.desc());

        LocalDateTime today = LocalDateTime.now();
        query.where(subscribePolicy.startDate.before(today).and(subscribePolicy.endDate.after(today)));

        return Optional.ofNullable(query.fetchFirst());
    }

}
