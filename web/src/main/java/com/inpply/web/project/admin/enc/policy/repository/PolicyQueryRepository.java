package com.inpply.web.project.admin.enc.policy.repository;


import com.inpply.common.domain.entity.Policy;
import com.inpply.global.repository.Querydsl4RepositorySupport;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.enc.policy.dto.PolicyDto;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import static com.inpply.common.domain.entity.QPolicy.policy;

@Repository
public class PolicyQueryRepository extends Querydsl4RepositorySupport {

    public PolicyQueryRepository() {
        super(Policy.class);
    }

    public Page<PolicyDto.ListItem> findAll(Pageable pageable, Search search) {

        JPAQuery<PolicyDto.ListItem> query =
                select(Projections.fields(PolicyDto.ListItem.class,
                        policy.id,
                        policy.policyType,
                        policy.version,
                        policy.createdDate
                )).from(policy);


        if (StringUtils.hasText(search.getKeyword())) {
            query.where(policy.contents.containsIgnoreCase(search.getKeyword()));
        }

        return applyPagination(pageable, query);
    }

}
