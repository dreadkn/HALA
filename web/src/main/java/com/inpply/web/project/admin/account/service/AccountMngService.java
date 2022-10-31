package com.inpply.web.project.admin.account.service;

import com.inpply.common.domain.user.model.User;
import com.inpply.global.exception.BusinessException;
import com.inpply.web.common.user.dto.PasswordDto;
import com.inpply.web.common.user.repository.RoleRepository;
import com.inpply.web.common.user.repository.UserRepository;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.project.admin.account.dto.MyInfoReqDto;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class AccountMngService {

    private final ApplicationEventPublisher eventPublisher;
    private final PasswordEncoder passwordEncoder;
    private final RoleRepository roleRepository;
    private final UserRepository userRepository;


    @Transactional
    public void updateMyInfo(String userId, MyInfoReqDto myInfoReqDto) {
        if (!userId.equals(myInfoReqDto.getUserId())) {
            throw new BusinessException("계정 정보를 수정할 수 없습니다.");
        }
        User user = userRepository.findByUserId(userId)
            .orElseThrow(() -> new EntityNotFoundException("계정", "userId", myInfoReqDto.getUserId()));
        user.change(myInfoReqDto.getName(), myInfoReqDto.getPhone(), myInfoReqDto.getEmail());
    }

    @Transactional
    public void changePassword(String userId, PasswordDto passwordDto) {
        User user = userRepository.findByUserId(userId)
            .orElseThrow(() -> new EntityNotFoundException("계정", "userId", userId));

        if (!user.isMatchesPassword(passwordDto.getOldPassword(), passwordEncoder)) {
            throw new BusinessException("비밀번호를 확인해주세요.", "oldPassword", passwordDto.getOldPassword());
        }

        user.changePassword(passwordDto.getNewPassword(), passwordEncoder);
    }
}
