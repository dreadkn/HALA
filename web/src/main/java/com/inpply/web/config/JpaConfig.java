package com.inpply.web.config;

import com.inpply.web.security.AuthenticationHelper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.data.domain.AuditorAware;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EntityScan(basePackages = {"com.inpply.**.domain", "com.inpply.**.model"})
@EnableJpaRepositories(basePackages = "com.inpply.**.repository",
    excludeFilters = @Filter(type = FilterType.REGEX, pattern = "com.inpply.*.*RedisRepository"))
@EnableTransactionManagement
@EnableJpaAuditing
@RequiredArgsConstructor
@Slf4j
public class JpaConfig {

    @Bean
    public AuditorAware<Long> auditorAware() {
        return AuthenticationHelper::getId;
    }

}
