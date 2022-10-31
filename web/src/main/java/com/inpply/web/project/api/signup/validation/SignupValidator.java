package com.inpply.web.project.api.signup.validation;

import com.inpply.web.global.validator.CustomValidator;
import com.inpply.web.project.api.signup.dto.SignupApiDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.util.regex.Pattern;

@Slf4j
@Component
@RequiredArgsConstructor
public class SignupValidator extends CustomValidator implements ConstraintValidator<ValidSignup, SignupApiDto.Request> {

    @Override
    public void initialize(final ValidSignup constraintAnnotation) {
    }

    @Override
    public boolean isValid(final SignupApiDto.Request requestDto, final ConstraintValidatorContext context) {


        String regex = "^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$";
        Pattern pattern = Pattern.compile(regex);
        if (!pattern.matcher(requestDto.getUserId()).matches()) {
            addConstraintViolation(context, "이메일 형식으로 등록해주세요.");
            return false;
        } else if (requestDto.getPassword().length() < 6 || requestDto.getPassword().length() > 16) {
            addConstraintViolation(context, "비밀번호는 6자 ~ 16자로 등록해주세요.");
            return false;
        }

        return true;
    }

}
