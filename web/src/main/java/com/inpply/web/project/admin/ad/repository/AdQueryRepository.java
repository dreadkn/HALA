package com.inpply.web.project.admin.ad.repository;


import com.inpply.common.domain.entity.Ad;
import com.inpply.global.repository.Querydsl4RepositorySupport;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.ad.dto.AdDto;
import com.querydsl.core.types.ExpressionUtils;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.JPAExpressions;
import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.time.LocalDateTime;
import java.util.List;

import static com.inpply.common.domain.entity.QAd.ad;
import static com.inpply.common.domain.entity.QEvent.event;
import static com.inpply.common.domain.entity.QMember.member;
import static com.inpply.common.domain.file.model.QFile.file;

@Repository
public class AdQueryRepository extends Querydsl4RepositorySupport {

    public AdQueryRepository() {
        super(Ad.class);
    }

    public Page<AdDto.ListItem> findAll(Pageable pageable, Search search) {

        JPAQuery<AdDto.ListItem> query =
                select(Projections.fields(AdDto.ListItem.class,
                        ad.id,
                        ad.adType,
                        ad.companyName,
                        ad.startDate,
                        ad.endDate,
                        ad.isPublic,
                        ad.readCount,
                        member.name,
                        ad.createdDate
                ))
                .from(ad)
                        .leftJoin(member).on(member.id.eq(ad.createdBy));

        if (StringUtils.hasText(search.getKeyword())) {
            query.where(ad.companyName.containsIgnoreCase(search.getKeyword())
                .or(member.name.containsIgnoreCase(search.getKeyword())));
        }

        return applyPagination(pageable, query);
    }

    public Page<AdDto.ListItem> findAllByApprove(Pageable pageable, Search search) {

        JPAQuery<AdDto.ListItem> query =
                select(Projections.fields(AdDto.ListItem.class,
                        ad.id,
                        ad.adType,
                        ad.companyName,
                        ad.startDate,
                        ad.endDate,
                        ad.isPublic,
                        ad.readCount,
                        member.name,
                        ad.inspection.inspectionUser.name.as("inspectionName"),
                        ad.createdDate
                ))
                        .from(ad)
                        .leftJoin(member).on(member.id.eq(ad.createdBy))
                        .leftJoin(ad.inspection)
                        .leftJoin(ad.inspection.inspectionUser);

        query.where(ad.isPublic.eq(true));

        if (StringUtils.hasText(search.getKeyword())) {
            query.where(ad.companyName.containsIgnoreCase(search.getKeyword())
                    .or(member.name.containsIgnoreCase(search.getKeyword())));
        }

        return applyPagination(pageable, query);
    }

    public List<AdDto.ApiListItem> findAllByActive() {

        JPAQuery<AdDto.ApiListItem> query =
                select(Projections.fields(AdDto.ApiListItem.class,
                        ad.id,
                        ad.url,
                        file
                ))
                        .from(ad)
                        .leftJoin(ad.files, file);

        LocalDateTime today = LocalDateTime.now();
        query.where(ad.startDate.before(today).and(ad.endDate.after(today)));


        return query.fetch();
    }

    public Page<AdDto.ApiListDto> findAllByUser(Pageable pageable, Long id) {

        JPAQuery<AdDto.ApiListDto> query =
                select(Projections.fields(AdDto.ApiListDto.class,
                        ad.id,
                        ad.adType,
                        ad.startDate,
                        ad.endDate,
                        ad.inspection.inspectionStatus,
                        ad.inspection.inspectionOpinion,
                        ExpressionUtils.as(
                                JPAExpressions
                                        .select(file.id.min())
                                        .from(file)
                                        .where(file.eq(ad.files.any())), "fileId")
                ))
                        .from(ad)
                        .leftJoin(ad.inspection)
                        .where(ad.createdBy.eq(id));

        query.where(ad.isPublic.eq(true));

        LocalDateTime today = LocalDateTime.now();
        query.where(ad.startDate.before(today).and(ad.endDate.after(today)));


        return applyPagination(pageable, query);
    }

    public List<AdDto.ApiListDto> findAllByApprove() {

        JPAQuery<AdDto.ApiListDto> query =
                select(Projections.fields(AdDto.ApiListDto.class,
                        ad.id,
                        ad.adType,
                        ad.startDate,
                        ad.endDate,
                        ad.inspection.inspectionStatus,
                        ad.inspection.inspectionOpinion,
                        ExpressionUtils.as(
                                JPAExpressions
                                        .select(file.id.min())
                                        .from(file)
                                        .where(file.eq(ad.files.any())), "fileId")
                ))
                        .from(ad)
                        .leftJoin(ad.inspection);

        query.where(ad.isPublic.eq(true));

        LocalDateTime today = LocalDateTime.now();
        query.where(ad.startDate.before(today).and(ad.endDate.after(today)));


        return query.fetch();
    }

}
