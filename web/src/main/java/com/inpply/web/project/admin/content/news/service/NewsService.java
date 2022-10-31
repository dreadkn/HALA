package com.inpply.web.project.admin.content.news.service;

import com.inpply.common.domain.entity.News;
import com.inpply.common.domain.repository.NewsRepository;
import com.inpply.web.global.exception.EntityNotFoundException;
import com.inpply.web.project.admin.content.news.dto.NewsDto;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class NewsService {

    private final NewsRepository newsRepository;
    private final ModelMapper modelMapper;

    public Long save(NewsDto newsDto)
    {
        newsDto.setIsPublic(false);
        News result = newsRepository.save(modelMapper.map(newsDto, News.class));
        return result.getId();
    }

    public Long update(Long id, NewsDto newsDto)
    {
        News news = getItem(id);

        news.change(newsDto.getIsPublic(),newsDto.getTitle(), newsDto.getContent(), newsDto.getHomepageUrl(), newsDto.getYoutubeUrl(), newsDto.getFiles());

        return news.getId();
    }

    public void delete(Long id)
    {
        News news = getItem(id);
        news.delete();
    }

    public NewsDto getDto(Long id)
    {
        News news = getItem(id);
        return modelMapper.map(news, NewsDto.class);
    }

    protected News getItem(Long id)
    {
        News news = newsRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("news", "newsId", id));
        return news;
    }

}
