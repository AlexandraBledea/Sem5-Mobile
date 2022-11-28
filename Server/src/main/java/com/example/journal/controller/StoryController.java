package com.example.journal.controller;

import com.example.journal.converter.StoryConverter;
import com.example.journal.dto.StoryDTO;
import com.example.journal.model.Story;
import com.example.journal.repository.StoryRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.Set;

@RestController
public class StoryController {

    private StoryRepository storyRepository;

    private StoryConverter storyConverter;

    public StoryController(StoryRepository storyRepository, StoryConverter storyConverter){
        this.storyRepository = storyRepository;
        this.storyConverter = storyConverter;
    }

    @GetMapping("/stories")
    public Set<StoryDTO> retrieveAllStories(){
        System.out.println("GET ALL");
        return storyConverter.convertModelsToDtos(storyRepository.findAll());
    }

    @PostMapping("/stories")
    public Story createStory(@RequestBody Story story){
        System.out.println("POST");

        return storyRepository.save(story);
    }

    @DeleteMapping("/stories/{id}")
    public Story deleteStory(@PathVariable long id) {
        System.out.println("DELETE");
        Optional<Story> storyOptional = storyRepository.findById(id);

        if(storyOptional.isEmpty()){
            return null;
        }

        storyRepository.deleteById(id);
        return storyOptional.get();
    }

    @PutMapping("/stories/{id}")
    public Story updateStory(@PathVariable long id, @RequestBody Story story){
        System.out.println("PUT");
        Optional<Story> storyOptional = storyRepository.findById(id);

        if(storyOptional.isEmpty()){
            return null;
        }

        story.setId(id);
        return storyRepository.save(story);
    }

}
