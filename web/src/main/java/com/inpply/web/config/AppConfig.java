package com.inpply.web.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.inpply.web.global.converter.BooleanDeserializer;
import com.inpply.web.security.ActiveUserStore;
import org.modelmapper.ModelMapper;
import org.modelmapper.convention.MatchingStrategies;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;

@Configuration
public class AppConfig {

	// beans
	@Bean
	public ActiveUserStore activeUserStore() {
		return new ActiveUserStore();
	}

	@Bean
	public ReloadableResourceBundleMessageSource messageSource() {
		ReloadableResourceBundleMessageSource source = new ReloadableResourceBundleMessageSource();
		source.setBasename("classpath:/messages");
		source.setDefaultEncoding("UTF-8");
		source.setCacheSeconds(60);
		return source;
	}

	@Bean
	public ObjectMapper objectMapper() {
		SimpleModule module = new SimpleModule();
		module.addDeserializer(Boolean.class, new BooleanDeserializer());
		return Jackson2ObjectMapperBuilder
				.json()
				.featuresToDisable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS)
				.modules(new JavaTimeModule(), module)
				.build();
	}



	@Bean
	public ModelMapper modelMapper() {
		ModelMapper modelMapper = new ModelMapper();
		modelMapper.getConfiguration().setMatchingStrategy(MatchingStrategies.STRICT);
		return modelMapper;
	}

}
