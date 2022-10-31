package com.inpply.web.user.member.dto;

import lombok.Data;

import javax.validation.constraints.NotEmpty;


public class FindDto {

	@Data
	public static class Request {
		@NotEmpty(message = "휴대폰 번호를 입력하세요.")
		private String phone;
		@NotEmpty(message = "이름을 입력하세요.")
		private String name;
	}

	@Data
	public static class Response {
		private String userId;
	}
}
