package com.example.journal.repository;

import com.example.journal.model.Story;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface StoryRepository extends JpaRepository<Story, Long> {
}
