package com.inpply.web.project.admin.enc.admin.repository;


import com.inpply.common.domain.user.model.User;
import com.inpply.global.repository.Querydsl4RepositorySupport;
import com.inpply.web.global.model.Search;
import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import static com.inpply.common.domain.user.model.QRole.role;
import static com.inpply.common.domain.user.model.QUser.user;

@Repository
public class AdminQueryRepository extends Querydsl4RepositorySupport {

    public AdminQueryRepository() {
        super(User.class);
    }

    public Page<User> findAll(Pageable pageable, Search search) {

        JPAQuery<User> query =
                selectFrom(user)
                        .leftJoin(user.roles, role).fetchJoin()
                        .where(role.name.ne("ROLE_SYSTEM").and(role.name.ne("ROLE_USER")));

        if (StringUtils.hasText(search.getKeyword())) {
            query.where(user.userId.containsIgnoreCase(search.getKeyword())
                .or(user.name.containsIgnoreCase(search.getKeyword()))
                .or(user.phone.containsIgnoreCase(search.getKeyword())));
        }

        return applyPagination(pageable, query);
    }

}
