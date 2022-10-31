package com.inpply.web.user.member.repository;

import com.inpply.common.domain.entity.Member;
import com.inpply.global.repository.Querydsl4RepositorySupport;
import com.inpply.web.user.member.dto.FindDto;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.stereotype.Repository;

import java.util.Optional;

import static com.inpply.common.domain.entity.QMember.member;

@Repository
public class UserQueryRepository extends Querydsl4RepositorySupport {
	public UserQueryRepository() {
		super(Member.class);
	}

	public Optional<FindDto.Response> findMember(FindDto.Request request) {
		JPAQuery<FindDto.Response> query = select(Projections.fields(FindDto.Response.class,
				member.userId
		))
				.from(member)
				.where(member.phone.eq(request.getPhone()).or(member.name.eq(request.getName())));


		return Optional.ofNullable(query.fetchOne());
	}
}
