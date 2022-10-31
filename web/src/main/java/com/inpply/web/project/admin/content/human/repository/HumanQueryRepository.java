package com.inpply.web.project.admin.content.human.repository;


import com.inpply.common.domain.entity.Event;
import com.inpply.common.domain.entity.Human;
import com.inpply.common.domain.type.ContentType;
import com.inpply.global.repository.Querydsl4RepositorySupport;
import com.inpply.web.global.model.Search;
import com.inpply.web.module.banner.model.Banner;
import com.inpply.web.project.admin.content.dto.ContentDto;
import com.inpply.web.project.admin.content.event.dto.EventDto;
import com.inpply.web.project.admin.content.human.dto.HumanDto;
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
import static com.inpply.common.domain.entity.QHuman.human;
import static com.inpply.common.domain.entity.QMember.member;
import static com.inpply.common.domain.entity.QNews.news;
import static com.inpply.common.domain.file.model.QFile.file;
import static com.inpply.web.module.banner.model.QBanner.banner;

@Repository
public class HumanQueryRepository extends Querydsl4RepositorySupport {

    public HumanQueryRepository() {
        super(Human.class);
    }

    public Page<HumanDto.ListItem> findAll(Pageable pageable, Search search) {

        JPAQuery<HumanDto.ListItem> query =
                select(Projections.fields(HumanDto.ListItem.class,
                        human.id,
                        human.krName,
                        human.isPublic,
                        human.createdDate,
                        human.readCount,
                        member.name
                ))
                .from(human)
                        .leftJoin(member).on(member.id.eq(human.createdBy))
                        .where(human.deleted.eq(false));

        if (StringUtils.hasText(search.getKeyword())) {
            query.where(human.krName.containsIgnoreCase(search.getKeyword())
                .or(human.enName.containsIgnoreCase(search.getKeyword()))
                    .or(human.cnName.containsIgnoreCase(search.getKeyword())));
        }

        return applyPagination(pageable, query);
    }

    public Page<HumanDto.ListItem> findAllByPublic(Pageable pageable, Search search) {

        JPAQuery<HumanDto.ListItem> query =
                select(Projections.fields(HumanDto.ListItem.class,
                        human.id,
                        human.krName,
                        human.enName,
                        human.cnName,
                        human.birthYear,
                        human.position,
                        human.education,
                        human.career,
                        human.isPublic,
                        human.createdDate,
                        human.readCount,
                        member.name,
                        ExpressionUtils.as(
                                JPAExpressions
                                        .select(file.id.min())
                                        .from(file)
                                        .where(file.eq(human.files.any())), "fileId")
                ))
                        .from(human)
                        .leftJoin(member).on(member.id.eq(human.createdBy))
                        .where(human.deleted.eq(false).and(human.isPublic.eq(true)));

        if (StringUtils.hasText(search.getTabName()))
        {
            switch (search.getTabName())
            {
                case "index1":
                    query.where(human.krName.between("강", "권"));
                    break;
                case "index2":
                    query.where(human.krName.between("권", "김"));
                    break;
                case "index3":
                    query.where(human.krName.between("나", "심"));
                    break;
                case "index4":
                    query.where(human.krName.between("안", "임"));
                    break;
                case "index5":
                    query.where(human.krName.between("장", "황"));
                    break;
            }
        }

        if (StringUtils.hasText(search.getKeyword())) {
            query.where(human.krName.containsIgnoreCase(search.getKeyword())
                    .or(human.enName.containsIgnoreCase(search.getKeyword()))
                    .or(human.cnName.containsIgnoreCase(search.getKeyword())));
        }

        return applyPagination(pageable, query);
    }

    public Page<HumanDto.ApiListItem> findAllByApi(Pageable pageable, Search search) {

        JPAQuery<HumanDto.ApiListItem> query =
                select(Projections.fields(HumanDto.ApiListItem.class,
                        human.id,
                        human.krName,
                        human.cnName,
                        human.enName,
                        human.position,
                        human.education,
                        human.career,
                        human.birthYear,
                        file
                ))
                        .from(human)
                        .leftJoin(human.files, file)
                        .leftJoin(member).on(member.id.eq(human.createdBy))
                        .where(human.deleted.eq(false));

        return applyPagination(pageable, query);
    }

    public HumanDto.ApiItem findByIdForApi(Long id) {

        JPAQuery<HumanDto.ApiItem> query =
                select(Projections.fields(HumanDto.ApiItem.class,
                        human.id,
                        human.krName,
                        human.cnName,
                        human.enName,
                        human.birthYear,
                        human.address,
                        human.email,
                        human.position,
                        human.education,
                        human.career,
                        human.awards,
                        file
                ))
                        .from(human)
                        .leftJoin(human.files, file)
                        .leftJoin(member).on(member.id.eq(human.createdBy));

        query.where(human.id.eq(id));

        return query.fetchFirst();
    }

    public List<ContentDto> findAllByContent(Search search) {

        JPAQuery<ContentDto> query =
                select(Projections.fields(ContentDto.class,
                        ExpressionUtils.as(Expressions.constant(ContentType.NEWS), "contentType"),
                        human.id,
                        human.krName.as("title"),
                        ExpressionUtils.as(
                                JPAExpressions
                                        .select(file.id.min())
                                        .from(file)
                                        .where(file.eq(human.files.any())), "fileId"),
                        member.name.as("createdName"),
                        human.createdDate

                ))
                        .from(human)
                        .leftJoin(member).on(member.id.eq(human.createdBy))
                        .where(human.deleted.eq(false).or(human.deleted.isNull()));
        if (search.getKeyword() != null)
            query.where(human.krName.containsIgnoreCase(search.getKeyword()));
        return query.fetch();
    }

}
