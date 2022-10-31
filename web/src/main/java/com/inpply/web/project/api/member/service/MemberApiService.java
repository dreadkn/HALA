package com.inpply.web.project.api.member.service;

import com.inpply.common.domain.entity.Member;
import com.inpply.common.domain.entity.Visitor;
import com.inpply.common.domain.file.model.File;
import com.inpply.common.domain.file.repository.FileRepository;
import com.inpply.common.domain.repository.MemberRepository;
import com.inpply.common.domain.repository.VisitorRepository;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.project.admin.subscribe.dto.SubscribeDto;
import com.inpply.web.project.admin.subscribe.service.SubscribeService;
import com.inpply.web.project.api.common.dto.ResultDto;
import com.inpply.web.project.api.member.dto.MemberApiDto;
import com.inpply.web.security.AuthenticationHelper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class MemberApiService {

    private final VisitorRepository visitorRepository;
    private final MemberRepository memberRepository;
    private final FileRepository fileRepository;
    private final PasswordEncoder passwordEncoder;
    private final SubscribeService subscribeService;

    @Transactional
    public ResultDto.Result updateMember(MemberApiDto.UpdateDto updateDto) {

        ResultDto.Result result = new ResultDto.Result();
        try {
            Long userId = AuthenticationHelper.getId().orElse(-1L);
            Member member = memberRepository.findById(userId)
                    .orElseThrow(() -> new EntityNotFoundException("회원", "id", userId));

            member.updateMember(updateDto.getPhone(), updateDto.getIsAgreeEmail(), updateDto.getIsAgreePush());

            memberRepository.save(member);
            result.setSuccess(member.getId());

        } catch (Exception e) {
            e.printStackTrace();
            result.setFailCode("FAIL");
        }
        return result;
    }

    @Transactional
    public ResultDto.Result changePw(MemberApiDto.ChangePwDto changePwDto) {

        ResultDto.Result result = new ResultDto.Result();
        try {
            Long userId = AuthenticationHelper.getId().orElse(-1L);
            Member member = memberRepository.findById(userId)
                    .orElseThrow(() -> new EntityNotFoundException("회원", "id", userId));

            if (!member.getPassword().equals(passwordEncoder.encode(changePwDto.getPassword())))
                result.setFail("현재 비밀번호가 일치하지 않습니다.");
            else if (!changePwDto.getPasswordNew().equals(changePwDto.getPasswordConfirm()))
                result.setFail("변경 비밀번호가 일치하지 않습니다.");
            else if (changePwDto.getPasswordNew().length() < 8 || changePwDto.getPasswordNew().length() > 20)
                result.setFail("비밀번호는 8~20자 사이어야 합니다.");
            else {
                member.setPassword(passwordEncoder.encode(changePwDto.getPassword()));
                result.setSuccess(member.getId());
                memberRepository.save(member);
            }

        } catch (Exception e) {
            e.printStackTrace();
            result.setFailCode("FAIL");
        }
        return result;
    }

    @Transactional
    public ResultDto.Result updateWithDraw() {

        ResultDto.Result result = new ResultDto.Result();
        try {
            Long userId = AuthenticationHelper.getId().orElse(-1L);
            Member member = memberRepository.findById(userId)
                    .orElseThrow(() -> new EntityNotFoundException("회원", "id", userId));

            member.updateWithdraw();
            memberRepository.save(member);

            result.setSuccess(member.getId());


        } catch (Exception e) {
            e.printStackTrace();
            result.setFailCode("FAIL");
        }
        return result;
    }

    @Transactional
    public ResultDto.Result updateVisitor(String visitorToken) {

        ResultDto.Result result = new ResultDto.Result();
        try {
            Long userId = AuthenticationHelper.getId().orElse(-1L);
            Member member = memberRepository.findById(userId)
                    .orElseThrow(() -> new EntityNotFoundException("회원", "id", userId));

            Visitor visitor = visitorRepository.findByVisitorToken(visitorToken).orElse(null);
            if (visitor != null && member != null && member.getVisitorId() == null) {
                member.updatevisitorId(visitor.getId());
                visitor.setMemberId(member.getId());
                memberRepository.save(member);
                visitorRepository.save(visitor);
                result.setSuccess(member.getId());
            } else if (member.getVisitorId() != null) {
                Visitor setVisitor = visitorRepository.findById(member.getVisitorId()).orElse(null);
                if (setVisitor != null) {
                    visitorRepository.delete(visitor);
                    result.setReserve1(setVisitor.getVisitorToken());
                    result.setSuccess(member.getId());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.setFailCode("FAIL");
        }
        return result;
    }

    public MemberApiDto.DetailDto getMemberInfo() {
        Long userId = AuthenticationHelper.getId().orElse(-1L);
        Member member = memberRepository.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("회원", "id", userId));

        MemberApiDto.DetailDto detailDto = new MemberApiDto.DetailDto(member);

        if (detailDto.getIsSubscribe()) {
            /**todo 구독정보 추가*/
        }

        return detailDto;
    }

    @Transactional
    public ResultDto.Result subscribe(SubscribeDto.Request request) {

        ResultDto.Result result = new ResultDto.Result();
        try {
            Long id = subscribeService.subscribe(request);
            result.setId(id);
        } catch (Exception e) {
            e.printStackTrace();
            result.setFailCode("FAIL");
        }
        return result;
    }

}
