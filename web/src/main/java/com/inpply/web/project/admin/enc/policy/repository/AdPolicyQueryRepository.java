package com.inpply.web.project.admin.enc.policy.repository;


import com.inpply.common.domain.entity.AdPolicy;
import com.inpply.global.repository.Querydsl4RepositorySupport;
import com.inpply.web.global.model.Search;
import com.inpply.web.module.banner.model.Banner;
import com.inpply.web.project.admin.enc.policy.dto.AdPolicyDto;
import com.inpply.web.project.admin.enc.policy.dto.PolicyDto;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import static com.inpply.common.domain.entity.QAdPolicy.adPolicy;
import static com.inpply.web.module.banner.model.QBanner.banner;

@Repository
public class AdPolicyQueryRepository extends Querydsl4RepositorySupport {

    public AdPolicyQueryRepository() {
        super(AdPolicy.class);
    }

    public Page<AdPolicyDto.ListItem> findAll(Pageable pageable, Search search) {

        JPAQuery<AdPolicyDto.ListItem> query =
                select(Projections.fields(AdPolicyDto.ListItem.class,
                        adPolicy.id,
                        adPolicy.startDate,
                        adPolicy.endDate,
                        adPolicy.adType,
                        adPolicy.periodType,
                        adPolicy.price
                ))
                .from(adPolicy);

        /**
         * todo : period, ad type
         */

        return applyPagination(pageable, query);
    }

}
