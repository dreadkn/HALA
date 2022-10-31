package com.inpply.web.project.admin.content.wedding.repository;


import com.inpply.common.domain.entity.Congratulations;
import com.inpply.common.domain.entity.Wedding;
import com.inpply.common.domain.type.CongratulationsType;
import com.inpply.common.domain.type.ContentType;
import com.inpply.global.repository.Querydsl4RepositorySupport;
import com.inpply.web.global.model.Search;
import com.inpply.web.module.banner.model.Banner;
import com.inpply.web.project.admin.content.dto.ContentDto;
import com.inpply.web.project.admin.content.wedding.dto.WeddingDto;
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

import static com.inpply.common.domain.entity.QCongratulations.congratulations;
import static com.inpply.common.domain.entity.QDeath.death;
import static com.inpply.common.domain.entity.QEvent.event;
import static com.inpply.common.domain.entity.QMember.member;
import static com.inpply.common.domain.entity.QNews.news;
import static com.inpply.common.domain.entity.QPerson.person;
import static com.inpply.common.domain.entity.QWedding.wedding;
import static com.inpply.common.domain.file.model.QFile.file;
import static com.inpply.web.module.banner.model.QBanner.banner;

@Repository
public class WeddingQueryRepository extends Querydsl4RepositorySupport {

    public WeddingQueryRepository() {
        super(Congratulations.class);
    }

    public Page<WeddingDto.ListItem> findAll(Pageable pageable, Search search) {

        JPAQuery<WeddingDto.ListItem> query =
                select(Projections.fields(WeddingDto.ListItem.class,
                        congratulations.id,
                        congratulations.dtype,
                        congratulations.title,
                        congratulations.isPublic,
                        congratulations.readCount,
                        member.name,
                        congratulations.createdDate
                ))
                .from(congratulations)
                        .leftJoin(member).on(member.id.eq(congratulations.createdBy))
                        .where(congratulations.deleted.eq(false));

        if (StringUtils.hasText(search.getKeyword())) {
            query.where(congratulations.title.containsIgnoreCase(search.getKeyword())
                .or(member.name.containsIgnoreCase(search.getKeyword())));
        }

        return applyPagination(pageable, query);
    }
    public Page<WeddingDto> findAllByWedding(Pageable pageable, Search search) {

        JPAQuery<WeddingDto> query =
                select(Projections.fields(WeddingDto.class,
                        wedding.id,
                        wedding.dtype,
                        wedding.isPublic,
                        wedding.title,
                        wedding.readCount,
                        member.name.as("createdName"),
                        wedding.createdDate,
                        wedding.bride,
                        wedding.brideJob,
                        wedding.brideFather,
                        wedding.brideMother,
                        wedding.groom,
                        wedding.groomJob,
                        wedding.groomFather,
                        wedding.groomMother,
                        wedding.partyDate,
                        wedding.partyPlace,
                        wedding.place,
                        wedding.weddingDate,
                        ExpressionUtils.as(
                                JPAExpressions
                                        .select(file.id.min())
                                        .from(file)
                                        .where(file.eq(wedding.files.any())), "fileId"),
                        file
                ))
                        .from(wedding)
                        .leftJoin(wedding.files, file)
                        .leftJoin(member).on(member.id.eq(wedding.createdBy))
                        .where(wedding.deleted.eq(false).and(wedding.isPublic.eq(true)))
                        .orderBy(wedding.createdDate.desc());

        if (StringUtils.hasText(search.getKeyword())) {
            query.where(wedding.title.containsIgnoreCase(search.getKeyword())
                    .or(member.name.containsIgnoreCase(search.getKeyword())));
        }

        return applyPagination(pageable, query);
    }

    public Page<WeddingDto> findAllByDeath(Pageable pageable, Search search) {

        JPAQuery<WeddingDto> query =
                select(Projections.fields(WeddingDto.class,
                        death.id,
                        death.dtype,
                        death.isPublic,
                        death.title,
                        death.readCount,
                        member.name.as("createdName"),
                        death.createdDate,
                        death.deceased,
                        death.deceasedJob,
                        death.illpho,
                        death.place,
                        death.outDate,
                        death.cemetery,
                        death.content,
                        ExpressionUtils.as(
                                JPAExpressions
                                        .select(file.id.min())
                                        .from(file)
                                        .where(file.eq(death.files.any())), "fileId"),
                        file
                ))
                        .from(death)
                        .leftJoin(death.files, file)
                        .leftJoin(member).on(member.id.eq(death.createdBy))
                        .where(death.deleted.eq(false).and(death.isPublic.eq(true)))
                        .orderBy(death.createdDate.desc());

        if (StringUtils.hasText(search.getKeyword())) {
            query.where(death.title.containsIgnoreCase(search.getKeyword())
                    .or(member.name.containsIgnoreCase(search.getKeyword())));
        }

        return applyPagination(pageable, query);
    }

    public Page<WeddingDto> findAllByPerson(Pageable pageable, Search search) {

        JPAQuery<WeddingDto> query =
                select(Projections.fields(WeddingDto.class,
                        person.id,
                        person.dtype,
                        person.isPublic,
                        person.title,
                        person.readCount,
                        member.name.as("createdName"),
                        person.createdDate,
                        person.content,
                        ExpressionUtils.as(
                                JPAExpressions
                                        .select(file.id.min())
                                        .from(file)
                                        .where(file.eq(person.files.any())), "fileId"),
                        file
                ))
                        .from(person)
                        .leftJoin(person.files, file)
                        .leftJoin(member).on(member.id.eq(person.createdBy))
                        .where(person.deleted.eq(false).and(person.isPublic.eq(true)))
                        .orderBy(person.createdDate.desc());

        if (StringUtils.hasText(search.getKeyword())) {
            query.where(person.title.containsIgnoreCase(search.getKeyword())
                    .or(member.name.containsIgnoreCase(search.getKeyword())));
        }

        return applyPagination(pageable, query);
    }

    public List<ContentDto> findAllByContent(Search search) {

        JPAQuery<ContentDto> query =
                select(Projections.fields(ContentDto.class,
                        ExpressionUtils.as(Expressions.constant(ContentType.NEWS), "contentType"),
                        congratulations.id,
                        congratulations.title,
                        ExpressionUtils.as(
                                JPAExpressions
                                        .select(file.id.min())
                                        .from(file)
                                        .where(file.eq(congratulations.files.any())), "fileId"),
                        member.name.as("createdName"),
                        congratulations.createdDate

                ))
                        .from(congratulations)
                        .leftJoin(member).on(member.id.eq(congratulations.createdBy))
                        .where(congratulations.deleted.eq(false).or(congratulations.deleted.isNull()));
        if (search.getKeyword() != null) {
            query.where(congratulations.title.containsIgnoreCase(search.getKeyword()));
        }
        return query.fetch();
    }


}
