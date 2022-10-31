package com.inpply.web.user.member.service;

import com.inpply.web.global.exception.UserNotFoundException;
import com.inpply.web.user.member.dto.FindDto;
import com.inpply.web.user.member.repository.UserQueryRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class UserFindService {
	private final UserQueryRepository userQueryRepository;

	public FindDto.Response findId(FindDto.Request request) {
		return userQueryRepository.findMember(request)
				.orElseThrow(() -> new UserNotFoundException("사용자 ID를 찾을 수 없습니다."));
	}
}
