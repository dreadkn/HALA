package com.inpply.web.project.admin.content.check.repository;


import com.inpply.common.domain.entity.ContentCheck;
import com.inpply.common.domain.entity.QMember;
import com.inpply.common.domain.type.InspectionStatus;
import com.inpply.global.repository.Querydsl4RepositorySupport;
import com.inpply.web.global.model.Search;
import com.inpply.web.module.banner.model.Banner;
import com.inpply.web.project.admin.content.check.dto.CheckDto;
import com.querydsl.core.types.ExpressionUtils;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.JPAExpressions;
import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.util.Optional;

import static com.inpply.common.domain.entity.QCongratulations.congratulations;
import static com.inpply.common.domain.entity.QContentCheck.contentCheck;
import static com.inpply.common.domain.entity.QEvent.event;
import static com.inpply.common.domain.entity.QHuman.human;
import static com.inpply.common.domain.entity.QMember.member;
import static com.inpply.common.domain.entity.QNews.news;
import static com.inpply.common.domain.file.model.QFile.file;
import static com.inpply.web.module.banner.model.QBanner.banner;

@Repository
public class CheckQueryRepository extends Querydsl4RepositorySupport {

    public CheckQueryRepository() {
        super(ContentCheck.class);
    }

    public Page<CheckDto.ListItem> findAll(Pageable pageable, Search search) {

        QMember newsMember = new QMember("newsMember");
        QMember eventMember = new QMember("eventMember");
        QMember congratulationsMember = new QMember("congratulationsMember");
        QMember humanMember = new QMember("humanMember");

        JPAQuery<CheckDto.ListItem> query =
                select(Projections.fields(CheckDto.ListItem.class,
                        contentCheck.id,
                        contentCheck.contentType,
                        contentCheck.inspection.inspectionStatus,
                        news.title.as("newsTitle"),
                        event.title.as("eventTitle"),
                        congratulations.title.as("congratulationsTitle"),
                        human.krName.as("humanTitle"),
                        news.createdDate.as("newsCreatedDate"),
                        event.createdDate.as("eventCreatedDate"),
                        congratulations.createdDate.as("congratulationsCreatedDate"),
                        human.createdDate.as("humanCreatedDate"),
                        newsMember.name.as("newsCreatedName"),
                        eventMember.name.as("eventCreatedName"),
                        congratulationsMember.name.as("congratulationsCreatedName"),
                        humanMember.name.as("humanCreatedName")
                ))
                .from(contentCheck)
                        .leftJoin(contentCheck.payment)
                        .leftJoin(contentCheck.inspection)
                        .leftJoin(news).on(news.id.eq(contentCheck.contentId))
                        .leftJoin(newsMember).on(newsMember.id.eq(news.createdBy))
                        .leftJoin(event).on(event.id.eq(contentCheck.contentId))
                        .leftJoin(eventMember).on(eventMember.id.eq(event.createdBy))
                        .leftJoin(congratulations).on(congratulations.id.eq(contentCheck.contentId))
                        .leftJoin(congratulationsMember).on(congratulationsMember.id.eq(congratulations.createdBy))
                        .leftJoin(human).on(human.id.eq(contentCheck.contentId))
                        .leftJoin(humanMember).on(humanMember.id.eq(human.createdBy));

        if (StringUtils.hasText(search.getKeyword())) {
            query.where(news.title.containsIgnoreCase(search.getKeyword())
                .or(event.title.containsIgnoreCase(search.getKeyword()))
                    .or(congratulations.title.containsIgnoreCase(search.getKeyword()))
                    .or(human.krName.containsIgnoreCase(search.getKeyword())));
        }

        return applyPagination(pageable, query);
    }

    public Page<CheckDto.ApiListItem> findAllByApi(Pageable pageable, Long userId) {

        JPAQuery<CheckDto.ApiListItem> query =
                select(Projections.fields(CheckDto.ApiListItem.class,
                        contentCheck.id,
                        contentCheck.contentType,
                        contentCheck.inspection.inspectionStatus,
                        contentCheck.inspection.inspectionOpinion,
                        news.title.as("newsTitle"),
                        event.title.as("eventTitle"),
                        congratulations.title.as("congratulationsTitle"),
                        human.krName.as("humanTitle")
                ))
                        .from(contentCheck)
                        .leftJoin(contentCheck.payment)
                        .leftJoin(contentCheck.inspection)
                        .leftJoin(news).on(news.id.eq(contentCheck.contentId).and(news.createdBy.eq(userId)))
                        .leftJoin(event).on(event.id.eq(contentCheck.contentId).and(news.createdBy.eq(userId)))
                        .leftJoin(congratulations).on(congratulations.id.eq(contentCheck.contentId).and(news.createdBy.eq(userId)))
                        .leftJoin(human).on(human.id.eq(contentCheck.contentId).and(news.createdBy.eq(userId)));



        return applyPagination(pageable, query);
    }

    public Page<CheckDto.ListItem> findAllByMember(Pageable pageable, Long memberId) {

        QMember newsMember = new QMember("newsMember");
        QMember eventMember = new QMember("eventMember");
        QMember congratulationsMember = new QMember("congratulationsMember");
        QMember humanMember = new QMember("humanMember");

        JPAQuery<CheckDto.ListItem> query =
                select(Projections.fields(CheckDto.ListItem.class,
                        contentCheck.id,
                        contentCheck.contentType,
                        contentCheck.inspection.inspectionStatus,
                        contentCheck.inspection.inspectionOpinion,
                        news.title.as("newsTitle"),
                        event.title.as("eventTitle"),
                        congratulations.title.as("congratulationsTitle"),
                        human.krName.as("humanTitle"),
                        news.createdDate.as("newsCreatedDate"),
                        event.createdDate.as("eventCreatedDate"),
                        congratulations.createdDate.as("congratulationsCreatedDate"),
                        human.createdDate.as("humanCreatedDate"),
                        newsMember.name.as("newsCreatedName"),
                        eventMember.name.as("eventCreatedName"),
                        congratulationsMember.name.as("congratulationsCreatedName"),
                        humanMember.name.as("humanCreatedName"),
                        ExpressionUtils.as(
                                JPAExpressions
                                        .select(file.id.min())
                                        .from(file)
                                        .where(file.eq(news.files.any())), "newsFileId"),
                        ExpressionUtils.as(
                                JPAExpressions
                                        .select(file.id.min())
                                        .from(file)
                                        .where(file.eq(event.files.any())), "eventFileId"),
                        ExpressionUtils.as(
                                JPAExpressions
                                        .select(file.id.min())
                                        .from(file)
                                        .where(file.eq(congratulations.files.any())), "congratulationsFileId"),
                        ExpressionUtils.as(
                                JPAExpressions
                                        .select(file.id.min())
                                        .from(file)
                                        .where(file.eq(human.files.any())), "humanFileId")
                ))
                        .from(contentCheck)
                        .leftJoin(contentCheck.payment)
                        .leftJoin(contentCheck.inspection)
                        .leftJoin(news).on(news.id.eq(contentCheck.contentId))
                        .leftJoin(newsMember).on(newsMember.id.eq(news.createdBy))
                        .leftJoin(event).on(event.id.eq(contentCheck.contentId))
                        .leftJoin(eventMember).on(eventMember.id.eq(event.createdBy))
                        .leftJoin(congratulations).on(congratulations.id.eq(contentCheck.contentId))
                        .leftJoin(congratulationsMember).on(congratulationsMember.id.eq(congratulations.createdBy))
                        .leftJoin(human).on(human.id.eq(contentCheck.contentId))
                        .leftJoin(humanMember).on(humanMember.id.eq(human.createdBy));

        query.where(congratulationsMember.id.eq(memberId).or(eventMember.id.eq(memberId)
                .or(newsMember.id.eq(memberId).or(humanMember.id.eq(memberId)))));

        return applyPagination(pageable, query);
    }

    public Optional<CheckDto.StatsDto> findStatsByMember(Long memberId) {

        QMember newsMember = new QMember("newsMember");
        QMember eventMember = new QMember("eventMember");
        QMember congratulationsMember = new QMember("congratulationsMember");
        QMember humanMember = new QMember("humanMember");

        JPAQuery<CheckDto.StatsDto> query =
                select(Projections.fields(CheckDto.StatsDto.class,
                        contentCheck.createdDate,
                        news.count().as("newsCount"),
                        event.count().as("eventCount"),
                        congratulations.count().as("congratulationsCount"),
                        human.count().as("humanCount"),
                        ExpressionUtils.as(
                                JPAExpressions
                                        .select(contentCheck.count())
                                        .from(contentCheck)
                                .leftJoin(contentCheck.inspection)
                                        .where(contentCheck.inspection.inspectionStatus.eq(InspectionStatus.WAIT)
                                                .or(contentCheck.inspection.inspectionStatus.eq(InspectionStatus.INSPECTION))), "waitCount"),
                        ExpressionUtils.as(
                                JPAExpressions
                                        .select(contentCheck.count())
                                        .from(contentCheck)
                                        .leftJoin(contentCheck.inspection)
                                        .where(contentCheck.inspection.inspectionStatus.eq(InspectionStatus.WAIT)
                                                .or(contentCheck.inspection.inspectionStatus.eq(InspectionStatus.INSPECTION))), "rejectCount"),
                        ExpressionUtils.as(
                                JPAExpressions
                                        .select(contentCheck.count())
                                        .from(contentCheck)
                                        .leftJoin(contentCheck.inspection)
                                        .where(contentCheck.inspection.inspectionStatus.eq(InspectionStatus.WAIT)
                                                .or(contentCheck.inspection.inspectionStatus.eq(InspectionStatus.INSPECTION))), "approveCount")

                ))
                        .from(contentCheck)
                        .leftJoin(contentCheck.payment)
                        .leftJoin(contentCheck.inspection)
                        .leftJoin(news).on(news.id.eq(contentCheck.contentId))
                        .leftJoin(newsMember).on(newsMember.id.eq(news.createdBy))
                        .leftJoin(event).on(event.id.eq(contentCheck.contentId))
                        .leftJoin(eventMember).on(eventMember.id.eq(event.createdBy))
                        .leftJoin(congratulations).on(congratulations.id.eq(contentCheck.contentId))
                        .leftJoin(congratulationsMember).on(congratulationsMember.id.eq(congratulations.createdBy))
                        .leftJoin(human).on(human.id.eq(contentCheck.contentId))
                        .leftJoin(humanMember).on(humanMember.id.eq(human.createdBy));

        query.where(congratulationsMember.id.eq(memberId).or(eventMember.id.eq(memberId)
                .or(newsMember.id.eq(memberId).or(humanMember.id.eq(memberId)))));

        return Optional.ofNullable(query.fetchFirst());
    }

    public CheckDto findById(Long id) {

        JPAQuery<CheckDto> query =
                select(Projections.fields(CheckDto.class,
                        contentCheck.id,
                        contentCheck.contentId,
                        contentCheck.contentType,
                        contentCheck.inspection,
                        contentCheck.payment
                ))
                        .from(contentCheck)
                        .leftJoin(member).on(member.id.eq(contentCheck.createdBy))
                        .leftJoin(contentCheck.payment)
                        .leftJoin(contentCheck.inspection)
                        .leftJoin(news).on(news.id.eq(contentCheck.contentId))
                        .leftJoin(event).on(event.id.eq(contentCheck.contentId))
                        .leftJoin(congratulations).on(congratulations.id.eq(contentCheck.contentId))
                        .leftJoin(human).on(human.id.eq(contentCheck.contentId));


        query.where(contentCheck.id.eq(id));

        return query.fetchFirst();
    }

}
