package com.inpply.web.project.admin.subscribe.repository;


import com.inpply.common.domain.entity.Subscriber;
import com.inpply.global.repository.Querydsl4RepositorySupport;
import com.inpply.web.global.model.Search;
import com.inpply.web.module.banner.model.Banner;
import com.inpply.web.project.admin.subscribe.dto.SubscribeDto;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.util.Optional;

import static com.inpply.common.domain.entity.QSubscriber.subscriber;
import static com.inpply.web.module.banner.model.QBanner.banner;

@Repository
public class SubscribeQueryRepository extends Querydsl4RepositorySupport {

    public SubscribeQueryRepository() {
        super(Subscriber.class);
    }

    public Page<SubscribeDto.ListItem> findAll(Pageable pageable, Search search) {

        JPAQuery<SubscribeDto.ListItem> query =
                select(Projections.fields(SubscribeDto.ListItem.class,
                        subscriber.id,
                        subscriber.startDate,
                        subscriber.endDate,
                        subscriber.member.name,
                        subscriber.member.subscribeUpdateCount,
                        subscriber.member.createdDate
                ))
                .from(subscriber)
                        .leftJoin(subscriber.member);

        if (StringUtils.hasText(search.getKeyword())) {
            query.where(subscriber.member.name.containsIgnoreCase(search.getKeyword()));
        }

        return applyPagination(pageable, query);
    }

    public Optional<SubscribeDto.MemberSubscribeDto> findByMember(Long id) {

        JPAQuery<SubscribeDto.MemberSubscribeDto> query =
                select(Projections.fields(SubscribeDto.MemberSubscribeDto.class,
                        subscriber.id,
                        subscriber.startDate,
                        subscriber.endDate,
                        subscriber.charger,
                        subscriber.tel,
                        subscriber.contentLeftCount,
                        subscriber.adLeftCount,
                        subscriber.payment,
                        subscriber.subscribeBenefit,
                        subscriber.member.createdDate
                ))
                        .from(subscriber)
                        .leftJoin(subscriber.member)
                        .leftJoin(subscriber.payment)
                        .leftJoin(subscriber.subscribeBenefit);

        query.where(subscriber.member.id.eq(id));


        return Optional.ofNullable(query.fetchFirst());
    }

}
