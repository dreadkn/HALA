package com.inpply.web.project.api.content.controller;

import com.inpply.common.domain.entity.AdPolicy;
import com.inpply.common.domain.type.AdType;
import com.inpply.common.domain.type.ContentType;
import com.inpply.web.global.model.Search;
import com.inpply.web.project.admin.content.check.dto.CheckDto;
import com.inpply.web.project.admin.content.check.repository.CheckQueryRepository;
import com.inpply.web.project.admin.content.check.service.CheckService;
import com.inpply.web.project.admin.content.event.dto.EventDto;
import com.inpply.web.project.admin.content.event.service.EventService;
import com.inpply.web.project.admin.content.human.dto.HumanDto;
import com.inpply.web.project.admin.content.human.service.HumanService;
import com.inpply.web.project.admin.content.news.dto.NewsDto;
import com.inpply.web.project.admin.content.news.service.NewsService;
import com.inpply.web.project.admin.content.wedding.dto.WeddingDto;
import com.inpply.web.project.admin.content.wedding.service.WeddingService;
import com.inpply.web.project.admin.enc.policy.dto.AdPolicyDto;
import com.inpply.web.project.api.common.dto.ResultDto;
import com.inpply.web.security.AuthenticationHelper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.transaction.Transactional;
import javax.validation.Valid;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/api/v1/content")
@Slf4j
@RequiredArgsConstructor
@Transactional
public class ContentApiControllerV1 {

    private final NewsService newsService;
    private final EventService eventService;
    private final CheckService checkService;
    private final WeddingService weddingService;
    private final HumanService humanService;
    private final CheckQueryRepository checkQueryRepository;


    /**
     * 내 콘텐츠 목록 조회
     */
    @GetMapping
    @ResponseBody
    public Page<CheckDto.ApiListItem> getMyContent(@PageableDefault Pageable pageable, Search search) {

        return checkQueryRepository.findAllByApi(pageable, AuthenticationHelper.getId().orElseGet(() -> 0l));
    }

    /**
     * 뉴스 등록/수정
     */
    @PostMapping(value = "/news")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public ResultDto.Result saveNews(@RequestBody @Valid NewsDto newsDto) {
        ResultDto.Result result = new ResultDto.Result();

        try{

            Long id = 0l;

            if(newsDto.getId() == null)
            {
                id = newsService.save(newsDto);
                checkService.add(ContentType.NEWS, id);
            }
            else
            {
                id = newsService.update(newsDto.getId(), newsDto);
            }
            result.setSuccess(id);

        } catch (Exception e){
            result.setFail("등록중 오류가 발생했습니다.");
        }

        return result;
    }


    /**
     * 행사 등록/수정
     */
    @PostMapping(value = "/event")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public ResultDto.Result saveEvent(@RequestBody @Valid EventDto eventDto) {
        ResultDto.Result result = new ResultDto.Result();

        try{

            Long id = 0l;

            if(eventDto.getId() == null)
            {
                id = eventService.save(eventDto);
                checkService.add(ContentType.EVENT, id);
            }
            else
            {
                id = eventService.update(eventDto.getId(), eventDto);
            }
            result.setSuccess(id);

        } catch (Exception e){
            result.setFail("등록중 오류가 발생했습니다.");
        }

        return result;
    }

    /**
     * 경조사 등록/수정
     */
    @PostMapping(value = "/congratulations")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public ResultDto.Result saveCongratulations(@RequestBody @Valid WeddingDto weddingDto) {
        ResultDto.Result result = new ResultDto.Result();

        try{

            Long id = 0l;

            if(weddingDto.getId() == null)
            {
                id = weddingService.save(weddingDto);
                checkService.add(ContentType.CONGRATULATIONS, id);
            }
            else
            {
                id = weddingService.update(weddingDto.getId(), weddingDto);
            }
            result.setSuccess(id);

        } catch (Exception e){
            result.setFail("등록중 오류가 발생했습니다.");
        }

        return result;
    }

    /**
     * 인명 등록/수정
     */
    @PostMapping(value = "/human")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public ResultDto.Result saveHuman(@RequestBody @Valid HumanDto humanDto) {
        ResultDto.Result result = new ResultDto.Result();

        try{

            Long id = 0l;

            if(humanDto.getId() == null)
            {
                id = humanService.save(humanDto);
                checkService.add(ContentType.HUMAN, id);
            }
            else
            {
                id = humanService.update(humanDto.getId(), humanDto);
            }
            result.setSuccess(id);

        } catch (Exception e){
            result.setFail("등록중 오류가 발생했습니다.");
        }

        return result;
    }

    /**
     * 콘텐츠 삭제
     */
    @PostMapping(value = "/delete")
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public ResultDto.Result deleteContent(@RequestParam ContentType contentType, @RequestParam Long id) {
        ResultDto.Result result = new ResultDto.Result();

        try{

            switch (contentType)
            {
                case NEWS:
                    newsService.delete(id);
                    break;
                case EVENT:
                    eventService.delete(id);
                    break;
                case CONGRATULATIONS:
                    weddingService.delete(id);
                    break;
                case HUMAN:
                    humanService.delete(id);
                    break;
            }

            result.setSuccess(id);

        } catch (Exception e){
            result.setFail("등록중 오류가 발생했습니다.");
        }

        return result;
    }



}
