package com.example.journal.converter;

import com.example.journal.dto.StoryDTO;
import com.example.journal.model.Story;
import lombok.extern.apachecommons.CommonsLog;
import org.springframework.stereotype.Component;

import java.util.Collection;
import java.util.Set;
import java.util.stream.Collectors;

@Component
public class StoryConverter implements Converter<Story, StoryDTO>{

    public Set<Long> convertModelsToIDs(Set<Story> models) {
        return models.stream()
                .map(model -> model.getId())
                .collect(Collectors.toSet());
    }

    public Set<Long> convertDTOsToIDs(Set<StoryDTO> dtos) {
        return dtos.stream()
                .map(dto -> dto.getId())
                .collect(Collectors.toSet());
    }

    public Set<StoryDTO> convertModelsToDtos(Collection<Story> models) {
        return models.stream()
                .map(model -> convertModelToDto(model))
                .collect(Collectors.toSet());
    }

    public Set<Story> convertDtosToModels(Collection<StoryDTO> dtos) {
        return dtos.stream()
                .map(this::convertDtoToModel)
                .collect(Collectors.toSet());
    }

    @Override
    public Story convertDtoToModel(StoryDTO storyDTO) {
        Story story = new Story(storyDTO.getId(), storyDTO.getTitle(), storyDTO.getDate(), storyDTO.getEmotion(), storyDTO.getMotivationalMessage(), storyDTO.getText());
//        story.setId(storyDTO.getId());
//        story.setTitle(storyDTO.getTitle());
//        story.setDate(storyDTO.getDate());
//        story.setEmotion(storyDTO.getEmotion());
//        story.setMotivationalMessage(storyDTO.getMotivationalMessage());
//        story.setText(storyDTO.getText());

        return story;
    }

    @Override
    public StoryDTO convertModelToDto(Story story) {
        StoryDTO dto = new StoryDTO(story.getId(), story.getTitle(), story.getDate(), story.getEmotion(), story.getMotivationalMessage(), story.getText());

        return dto;
    }
}
