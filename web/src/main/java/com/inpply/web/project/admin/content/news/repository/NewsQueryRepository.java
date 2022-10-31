package com.inpply.web.project.admin.content.news.repository;


import com.inpply.common.domain.entity.News;
import com.inpply.common.domain.type.ContentType;
import com.inpply.global.repository.Querydsl4RepositorySupport;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.content.news.dto.NewsDto;
import com.inpply.web.project.admin.content.dto.ContentDto;
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

import static com.inpply.common.domain.entity.QMember.member;
import static com.inpply.common.domain.entity.QNews.news;
import static com.inpply.common.domain.file.model.QFile.file;

@Repository
public class NewsQueryRepository extends Querydsl4RepositorySupport {

    public NewsQueryRepository() {
        super(News.class);
    }

    public Page<NewsDto.ListItem> findAll(Pageable pageable, Search search) {

        JPAQuery<NewsDto.ListItem> query =
                select(Projections.fields(NewsDto.ListItem.class,
                        news.id,
                        news.title,
                        news.content,
                        news.isPublic,
                        member.name,
                        news.readCount,
                        news.createdDate,
                        ExpressionUtils.as(
                                JPAExpressions
                                        .select(file.id.min())
                                        .from(file)
                                        .where(file.eq(news.files.any())), "fileId")
                ))
                .from(news)
                        .leftJoin(member).on(member.id.eq(news.createdBy))
                        .where(news.deleted.eq(false).or(news.deleted.isNull()));

        if (StringUtils.hasText(search.getKeyword())) {
            query.where(news.title.containsIgnoreCase(search.getKeyword())
                .or(news.content.containsIgnoreCase(search.getKeyword())));
        }

        return applyPagination(pageable, query);
    }

    public Page<NewsDto.ListItem> findAllByPublic(Pageable pageable, Search search) {

        JPAQuery<NewsDto.ListItem> query =
                select(Projections.fields(NewsDto.ListItem.class,
                        news.id,
                        news.title,
                        news.content,
                        news.isPublic,
                        member.name,
                        news.readCount,
                        news.createdDate,
                        ExpressionUtils.as(
                                JPAExpressions
                                        .select(file.id.min())
                                        .from(file)
                                        .where(file.eq(news.files.any())), "fileId")
                ))
                        .from(news)
                        .leftJoin(member).on(member.id.eq(news.createdBy))
                        .where(news.deleted.eq(false).or(news.deleted.isNull()))
                        .where(news.isPublic.eq(true));

        if (StringUtils.hasText(search.getKeyword())) {
            query.where(news.title.containsIgnoreCase(search.getKeyword())
                    .or(news.content.containsIgnoreCase(search.getKeyword())));
        }

        return applyPagination(pageable, query);
    }

    public Page<NewsDto.ApiListItem> findAllByApi(Pageable pageable, Search search) {

        JPAQuery<NewsDto.ApiListItem> query =
                select(Projections.fields(NewsDto.ApiListItem.class,
                        news.id,
                        news.title,
                        news.content,
                        member.name.as("createdName"),
                        news.createdDate,
                        file

                ))
                        .from(news)
                        .leftJoin(news.files, file)
                        .leftJoin(member).on(member.id.eq(news.createdBy))
                        .where(news.deleted.eq(false).or(news.deleted.isNull()));

        return applyPagination(pageable, query);
    }

    public List<ContentDto> findAllByContent(Search search) {

        JPAQuery<ContentDto> query =
                select(Projections.fields(ContentDto.class,
                        ExpressionUtils.as(Expressions.constant(ContentType.NEWS), "contentType"),
                        news.id,
                        news.title,
                        ExpressionUtils.as(
                                JPAExpressions
                                        .select(file.id.min())
                                        .from(file)
                                        .where(file.eq(news.files.any())), "fileId"),
                        member.name.as("createdName"),
                        news.createdDate

                ))
                        .from(news)
                        .leftJoin(member).on(member.id.eq(news.createdBy))
                        .where(news.deleted.eq(false).or(news.deleted.isNull()));

        if (search.getKeyword() != null)
            query.where(news.title.containsIgnoreCase(search.getKeyword()));
        return query.fetch();
    }

    public NewsDto findById(Long id) {

        JPAQuery<News> query =
                selectFrom(news)
                        .leftJoin(member).on(member.id.eq(news.createdBy))
                        .leftJoin(news.files, file)
                        .where(news.deleted.eq(false));

        Map<Long, NewsDto> transform = query.transform(
                GroupBy.groupBy(news.id)
                        .as(
                                Projections.fields(NewsDto.class,
                                        news.id,
                                        news.title,
                                        news.content,
                                        news.homepageUrl,
                                        news.youtubeUrl,
                                        news.isPublic,
                                        member.name,
                                        news.readCount,
                                        news.createdDate,
                                        GroupBy.list(file).as("files")
                                )
                        ));

        return transform.get(id);
    }
    public NewsDto.ApiItem findByIdForApi(Long id) {

        JPAQuery<News> query =
                selectFrom(news)
                        .leftJoin(member).on(member.id.eq(news.createdBy))
                        .leftJoin(news.files, file)
                        .where(news.deleted.eq(false));

        Map<Long, NewsDto.ApiItem> transform = query.transform(
                GroupBy.groupBy(news.id)
                        .as(
                                Projections.fields(NewsDto.ApiItem.class,
                                        news.id,
                                        news.title,
                                        news.content,
                                        news.homepageUrl,
                                        news.youtubeUrl,
                                        member.name.as("createdName"),
                                        news.createdDate,
                                        GroupBy.list(file).as("files")
                                )
                        ));

        return transform.get(id);
    }


}
