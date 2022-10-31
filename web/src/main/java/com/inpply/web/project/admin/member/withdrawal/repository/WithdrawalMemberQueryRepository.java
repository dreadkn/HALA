package com.inpply.web.project.admin.member.withdrawal.repository;


import com.inpply.common.domain.entity.Member;
import com.inpply.global.repository.Querydsl4RepositorySupport;
import com.inpply.global.type.AdminType;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.member.normal.dto.MemberDto;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import static com.inpply.common.domain.entity.QMember.member;

@Repository
public class WithdrawalMemberQueryRepository extends Querydsl4RepositorySupport {

    public WithdrawalMemberQueryRepository() {
        super(Member.class);
    }

    public Page<MemberDto.ListItem> findAll(Pageable pageable, Search search) {

        JPAQuery<MemberDto.ListItem> query =
                select(Projections.fields(MemberDto.ListItem.class,
                        member.id,
                        member.userId,
                        member.name,
                        member.contentCount,
                        member.withdrawalDate,
                        member.createdDate
                ))
                        .from(member)
                        .where(member.adminType.eq(AdminType.USER))
                        .where(member.isWithdrawal.eq(true));

        if (StringUtils.hasText(search.getKeyword())) {
            query.where(member.userId.containsIgnoreCase(search.getKeyword())
                    .or(member.name.containsIgnoreCase(search.getKeyword())));
        }

        return applyPagination(pageable, query);
    }

}
