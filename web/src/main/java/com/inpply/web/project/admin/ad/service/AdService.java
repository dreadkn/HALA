package com.inpply.web.project.admin.ad.service;

import com.inpply.common.domain.entity.Ad;
import com.inpply.common.domain.entity.ContentCheck;
import com.inpply.common.domain.entity.Inspection;
import com.inpply.common.domain.entity.Payment;
import com.inpply.common.domain.repository.AdRepository;
import com.inpply.common.domain.type.InspectionStatus;
import com.inpply.common.domain.type.PaymentStatus;
import com.inpply.common.domain.user.model.User;
import com.inpply.web.common.user.repository.UserRepository;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.project.admin.ad.dto.AdDto;
import com.inpply.web.security.AuthenticationHelper;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class AdService {

    private final AdRepository adRepository;
    private final UserRepository userRepository;
    private final ModelMapper modelMapper;

    public Long save(AdDto.ApiDto adDto){
        return save(modelMapper.map(adDto, AdDto.Request.class));
    }
    public Long save(AdDto.PeriodRequest adDto){
        return save(modelMapper.map(adDto, AdDto.Request.class));
    }
    public Long save(AdDto.Request adDto)
    {
        adDto.setIsPublic(false);
        Ad ad = modelMapper.map(adDto, Ad.class);
        ad.setPayment(Payment.builder()
                        .paymentStatus(adDto.getPayment().getPaymentStatus())
                        .paymentType(adDto.getPayment().getPaymentType())
                        .price(adDto.getPayment().getPrice())
                        .approveNumber(adDto.getPayment().getApproveNumber())
                .build());
        ad.setInspection(Inspection.builder()
                        .inspectionUser(getUser())
                        .inspectionDate(LocalDateTime.now())
                .inspectionStatus(InspectionStatus.WAIT)
                .build());

        Ad result = adRepository.save(ad);

        checkInspection(result);

        return result.getId();
    }

    public Long update(Long id, AdDto.ApiDto adDto){
        return update(id, modelMapper.map(adDto, AdDto.Request.class));
    }

    public Long update(Long id, AdDto.Request adDto)
    {
        Ad ad = getItem(id);

        ad.change(adDto.getAdType(), adDto.getCompanyName(), adDto.getCharger(), adDto.getTel(), adDto.getUrl(), adDto.getStartDate(), adDto.getEndDate(), adDto.getFiles(), adDto.getMobileFiles());

        ad.getInspection().setInspectionStatus(adDto.getInspection().getInspectionStatus());
        checkInspection(ad);

        return ad.getId();
    }

    public void delete(Long id)
    {
        adRepository.deleteById(id);
    }

    public AdDto getDto(Long id)
    {
        Ad ad = getItem(id);
        return modelMapper.map(ad, AdDto.class);
    }

    protected Ad getItem(Long id)
    {
        Ad ad = adRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("ad", "adId", id));
        return ad;
    }

    protected User getUser()
    {
        User user = userRepository.findById(AuthenticationHelper.getId().orElseGet(() -> 0l))
                .orElseThrow(() -> new EntityNotFoundException("user", "user", "login"));
        return user;
    }

    protected void checkInspection(Ad ad)
    {
        switch (ad.getInspection().getInspectionStatus())
        {
            case WAIT:
            case INSPECTION:
                ad.notPublic();
                break;
            case APPROVE:
                ad.approve();
                break;
            case REJECT:
                ad.reject(ad.getInspection().getInspectionOpinion());
                break;
        }

    }

}
