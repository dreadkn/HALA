package com.inpply.web.project.admin.enc.policy.repository;


import com.inpply.common.domain.entity.ContentPolicy;
import com.inpply.common.domain.entity.QContentPolicy;
import com.inpply.global.repository.Querydsl4RepositorySupport;
import com.inpply.web.global.model.Search;
import com.inpply.web.module.banner.model.Banner;
import com.inpply.web.project.admin.enc.policy.dto.ContentPolicyDto;
import com.inpply.web.project.admin.enc.policy.dto.PolicyDto;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import static com.inpply.common.domain.entity.QContentPolicy.contentPolicy;
import static com.inpply.web.module.banner.model.QBanner.banner;

@Repository
public class ContentPolicyQueryRepository extends Querydsl4RepositorySupport {

    public ContentPolicyQueryRepository() {
        super(ContentPolicy.class);
    }

    public Page<ContentPolicyDto.ListItem> findAll(Pageable pageable, Search search) {

        JPAQuery<ContentPolicyDto.ListItem> query =
                select(Projections.fields(ContentPolicyDto.ListItem.class,
                        contentPolicy.id,
                        contentPolicy.startDate,
                        contentPolicy.endDate,
                        contentPolicy.contentType,
                        contentPolicy.price
                ))
                .from(contentPolicy);

        /**
         * todo : period
         */

        return applyPagination(pageable, query);
    }

}
