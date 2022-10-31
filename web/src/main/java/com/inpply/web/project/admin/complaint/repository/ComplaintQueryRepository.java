package com.inpply.web.project.admin.complaint.repository;


import com.inpply.common.domain.entity.Broken;
import com.inpply.global.repository.Querydsl4RepositorySupport;
import com.inpply.web.global.model.Search;
import com.inpply.web.module.banner.model.Banner;
import com.inpply.web.project.admin.complaint.dto.ComplaintDto;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import static com.inpply.common.domain.entity.QBroken.broken;
import static com.inpply.common.domain.entity.QMember.member;
import static com.inpply.web.module.banner.model.QBanner.banner;

@Repository
public class ComplaintQueryRepository extends Querydsl4RepositorySupport {

    public ComplaintQueryRepository() {
        super(Broken.class);
    }

    public Page<ComplaintDto.ListItem> findAll(Pageable pageable, Search search) {

        JPAQuery<ComplaintDto.ListItem> query =
                select(Projections.fields(ComplaintDto.ListItem.class,
                        broken.id,
                        broken.title,
                        broken.brokenStatus,
                        broken.brokenType,
                        broken.readCount,
                        broken.createdDate,
                        member.name
                ))
                .from(broken)
                        .leftJoin(member).on(member.id.eq(broken.createdBy));

        if (StringUtils.hasText(search.getKeyword())) {
            query.where(broken.title.containsIgnoreCase(search.getKeyword())
                .or(broken.content.containsIgnoreCase(search.getKeyword())));
        }

        return applyPagination(pageable, query);
    }

}
