package com.inpply.web.project.admin.member.service;

import com.inpply.common.domain.entity.Member;
import com.inpply.common.domain.repository.MemberRepository;
import com.inpply.common.domain.user.model.Role;
import com.inpply.common.domain.user.model.User;
import com.inpply.global.type.AdminType;
import com.inpply.web.common.user.repository.RoleRepository;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.project.admin.member.normal.dto.MemberDto;
import com.inpply.web.project.api.common.dto.ResultDto;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Arrays;
import java.util.HashSet;
import java.util.concurrent.ThreadLocalRandom;

@Service
@RequiredArgsConstructor
@Transactional
public class MemberService {

    private final MemberRepository memberRepository;
    private final RoleRepository roleRepository;
    private final ModelMapper modelMapper;
    private final PasswordEncoder passwordEncoder;

    public Long save(MemberDto memberDto)
    {
        memberDto.setAdminType(AdminType.USER);

        Member member = modelMapper.map(memberDto, Member.class);

        Role role = roleRepository.findByName(member.getAdminType().getRole())
                .orElseThrow(() -> new EntityNotFoundException("역활", "role", member.getAdminType().getRole()));

        member.setRoles(new HashSet<>(Arrays.asList(role)));
        member.setEnabled(true);
        member.setPassword(passwordEncoder.encode(member.getPassword()));

        Member result = memberRepository.save(member);

        return result.getId();
    }

    public Long update(Long id, MemberDto memberDto)
    {
        Member member = getItem(id);

        member.change(memberDto.getName(), memberDto.getPhone(), memberDto.getEmail(), memberDto.getIsPushAlarm(), memberDto.getIsEmailAlarm());

        return member.getId();
    }

    public Long update(Long id, MemberDto.UserRequest memberDto)
    {
        Member member = getItem(id);

        member.change(memberDto.getName(), memberDto.getPhone(), memberDto.getEmail());

        return member.getId();
    }

    public void block(Long id)
    {
        Member member = getItem(id);
        member.block();
    }

    public void unblock(Long id)
    {
        Member member = getItem(id);
        member.unblock();
    }

    public void withdrawal(Long id)
    {
        Member member = getItem(id);
        member.withdrawal();
    }

    public void delete(Long id)
    {
        memberRepository.deleteById(id);
    }

    public MemberDto getDto(Long id)
    {
        Member member = getItem(id);
        return modelMapper.map(member, MemberDto.class);
    }

    protected Member getItem(Long id)
    {
        Member member = memberRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("member", "memberId", id));
        return member;
    }

    @org.springframework.transaction.annotation.Transactional
    public ResultDto.Result changePassword(String userId) {
        ResultDto.Result result = new ResultDto.Result();

        try {
            Member member = memberRepository.findByUserId(userId).orElseThrow(() -> new EntityNotFoundException("데이터", "id", userId));

            Integer tempPassword = ThreadLocalRandom.current().nextInt(100000, 1000000);
            member.setPassword(passwordEncoder.encode(tempPassword.toString()));
            memberRepository.save(member);

            result.setSuccess(member.getId());
            result.setReserve1(tempPassword.toString());
            result.setReserve2(userId);
        } catch (Exception e) {
            result.setFail("이메일 정보가 없습니다.");
        }

        return result;
    }
}
