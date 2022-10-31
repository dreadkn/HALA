package com.inpply.web.project.admin.account.validation;

import com.inpply.web.common.user.repository.UserRepository;
import com.inpply.web.global.validator.CustomValidator;
import com.inpply.web.project.admin.account.dto.MyInfoReqDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

@Slf4j
@Component
@RequiredArgsConstructor
public class MyInfoValidator extends
        CustomValidator implements ConstraintValidator<ValidMyInfo, MyInfoReqDto> {

    private final UserRepository userRepository;

    @Override
    public void initialize(final ValidMyInfo constraintAnnotation) {
    }

    @Override
    public boolean isValid(final MyInfoReqDto obj, final ConstraintValidatorContext context) {
        int invalidCount = 0;

        boolean existsByEmail = userRepository.existByEmailAndNotInUserId(obj.getEmail(), obj.getUserId());
        if (existsByEmail) {
            invalidCount++;
            addConstraintViolation(context, "이미 사용중인 이메일 주소입니다. 다른 이메일을 입력해주세요.", "email");
        }

        return invalidCount == 0;
    }

}
