package com.inpply.web.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;

@Configuration
@EnableScheduling
public class TaskConfig implements SchedulingConfigurer {
	private final int POOL_SIZE = 15;
	@Override
	public void configureTasks(ScheduledTaskRegistrar scheduledTaskRegistrar) {
		final ThreadPoolTaskScheduler threadPoolTaskScheduler = new ThreadPoolTaskScheduler();
		threadPoolTaskScheduler.setPoolSize(POOL_SIZE);
		threadPoolTaskScheduler.setThreadNamePrefix("scheduler-pool-");
		threadPoolTaskScheduler.initialize();
		scheduledTaskRegistrar.setTaskScheduler(threadPoolTaskScheduler);
	}


}
