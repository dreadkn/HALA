package com.inpply.web.project.admin.content.event.repository;


import com.inpply.common.domain.entity.Event;
import com.inpply.common.domain.entity.News;
import com.inpply.common.domain.type.ContentType;
import com.inpply.global.repository.Querydsl4RepositorySupport;
import com.inpply.web.global.model.Search;
import com.inpply.web.module.banner.model.Banner;
import com.inpply.web.project.admin.content.dto.ContentDto;
import com.inpply.web.project.admin.content.event.dto.EventDto;
import com.inpply.web.project.admin.content.news.dto.NewsDto;
import com.querydsl.core.group.GroupBy;
import com.querydsl.core.types.ExpressionUtils;
import com.querydsl.core.types.Projections;
import com.querydsl.core.types.dsl.Expressions;
import com.querydsl.jpa.JPAExpressions;
import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;

import static com.inpply.common.domain.entity.QEvent.event;
import static com.inpply.common.domain.entity.QMember.member;
import static com.inpply.common.domain.entity.QNews.news;
import static com.inpply.common.domain.file.model.QFile.file;
import static com.inpply.web.module.banner.model.QBanner.banner;

@Repository
public class EventQueryRepository extends Querydsl4RepositorySupport {

    public EventQueryRepository() {
        super(Event.class);
    }

    public Page<EventDto.ListItem> findAll(Pageable pageable, Search search) {

        JPAQuery<EventDto.ListItem> query =
                select(Projections.fields(EventDto.ListItem.class,
                        event.id,
                        event.title,
                        event.isPublic,
                        member.name,
                        event.content,
                        event.readCount,
                        event.createdDate,
                        ExpressionUtils.as(
                                JPAExpressions
                                        .select(file.id.min())
                                        .from(file)
                                        .where(file.eq(event.files.any())), "fileId")
                ))
                .from(event)
                        .leftJoin(member).on(member.id.eq(event.createdBy))
                        .where(event.deleted.eq(false));

        if (StringUtils.hasText(search.getKeyword())) {
            query.where(event.title.containsIgnoreCase(search.getKeyword())
                .or(event.content.containsIgnoreCase(search.getKeyword())));
        }

        return applyPagination(pageable, query);
    }

    public Page<EventDto.ListItem> findAllByPublic(Pageable pageable, Search search) {

        JPAQuery<EventDto.ListItem> query =
                select(Projections.fields(EventDto.ListItem.class,
                        event.id,
                        event.title,
                        event.isPublic,
                        member.name,
                        event.content,
                        event.readCount,
                        event.createdDate,
                        ExpressionUtils.as(
                                JPAExpressions
                                        .select(file.id.min())
                                        .from(file)
                                        .where(file.eq(event.files.any())), "fileId")
                ))
                        .from(event)
                        .leftJoin(member).on(member.id.eq(event.createdBy))
                        .where(event.deleted.eq(false).and(event.isPublic.eq(true)));

        if (StringUtils.hasText(search.getKeyword())) {
            query.where(event.title.containsIgnoreCase(search.getKeyword())
                    .or(event.content.containsIgnoreCase(search.getKeyword())));
        }

        return applyPagination(pageable, query);
    }
    public Page<EventDto.ApiListItem> findAllByApi(Pageable pageable, Search search) {

        JPAQuery<EventDto.ApiListItem> query =
                select(Projections.fields(EventDto.ApiListItem.class,
                        event.id,
                        event.title,
                        member.name.as("createdName"),
                        event.content,
                        event.createdDate,
                        file
                ))
                        .from(event)
                        .leftJoin(event.files, file)
                        .leftJoin(member).on(member.id.eq(event.createdBy))
                        .where(event.deleted.eq(false));

        return applyPagination(pageable, query);
    }

    public List<ContentDto> findAllByContent(Search search) {

        JPAQuery<ContentDto> query =
                select(Projections.fields(ContentDto.class,
                        ExpressionUtils.as(Expressions.constant(ContentType.EVENT), "contentType"),
                        event.id,
                        event.title,
                        ExpressionUtils.as(
                                JPAExpressions
                                        .select(file.id.min())
                                        .from(file)
                                        .where(file.eq(event.files.any())), "fileId"),
                        member.name.as("createdName"),
                        event.createdDate

                ))
                        .from(event)
                        .leftJoin(member).on(member.id.eq(event.createdBy))
                        .where(event.deleted.eq(false).or(event.deleted.isNull()));
        if (search.getKeyword() != null)
            query.where(event.title.containsIgnoreCase(search.getKeyword()));
        return query.fetch();
    }


    public EventDto findById(Long id) {

        JPAQuery<Event> query =
                selectFrom(event)
                        .leftJoin(member).on(member.id.eq(event.createdBy))
                        .leftJoin(event.files, file)
                        .where(event.deleted.eq(false));

        Map<Long, EventDto> transform = query.transform(
                GroupBy.groupBy(event.id)
                        .as(
                                Projections.fields(EventDto.class,
                                        event.id,
                                        event.title,
                                        event.content,
                                        event.homepageUrl,
                                        event.youtubeUrl,
                                        event.isPublic,
                                        member.name,
                                        event.readCount,
                                        event.createdDate,
                                        GroupBy.list(file).as("files")
                                )
                        ));

        return transform.get(id);
    }

    public EventDto.ApiItem findByIdForApi(Long id) {

        JPAQuery<Event> query =
                selectFrom(event)
                        .leftJoin(member).on(member.id.eq(event.createdBy))
                        .leftJoin(event.files, file)
                        .where(event.deleted.eq(false));

        Map<Long, EventDto.ApiItem> transform = query.transform(
                GroupBy.groupBy(event.id)
                        .as(
                                Projections.fields(EventDto.ApiItem.class,
                                        event.id,
                                        event.title,
                                        event.content,
                                        event.homepageUrl,
                                        event.youtubeUrl,
                                        member.name.as("createdName"),
                                        event.createdDate,
                                        GroupBy.list(file).as("files")
                                )
                        ));

        return transform.get(id);
    }

}
