package com.inpply.web.project.admin.enc.version.repository;


import com.inpply.common.domain.entity.AppVersion;
import com.inpply.common.domain.type.AppType;
import com.inpply.global.repository.Querydsl4RepositorySupport;
import com.inpply.web.global.model.Search;
import com.inpply.web.module.banner.model.Banner;
import com.inpply.web.project.admin.enc.version.dto.VersionDto;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import static com.inpply.common.domain.entity.QAppVersion.appVersion;
import static com.inpply.web.module.banner.model.QBanner.banner;

@Repository
public class VersionQueryRepository extends Querydsl4RepositorySupport {

    public VersionQueryRepository() {
        super(AppVersion.class);
    }

    public Page<VersionDto.ListItem> findAll(Pageable pageable, Search search) {

        JPAQuery<VersionDto.ListItem> query =
                select(Projections.fields(VersionDto.ListItem.class,
                        appVersion.id,
                        appVersion.appType,
                        appVersion.version,
                        appVersion.isEssentialUpdate
                ))
                .from(appVersion);

        /**
         * todo : app type
         */

        if (StringUtils.hasText(search.getKeyword())) {
            query.where(appVersion.version.containsIgnoreCase(search.getKeyword()));
        }

        return applyPagination(pageable, query);
    }

    public VersionDto.ApiItem findByAppType(AppType appType) {

        JPAQuery<VersionDto.ApiItem> query =
                select(Projections.fields(VersionDto.ApiItem.class,
                        appVersion.version,
                        appVersion.isEssentialUpdate.as("isRequiredUpdate")
                ))
                        .from(appVersion)
                        .orderBy(appVersion.createdDate.desc());

        query.where(appVersion.appType.eq(appType));

        return query.fetchFirst();
    }

}
