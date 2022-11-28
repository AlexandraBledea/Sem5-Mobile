package com.example.journal.model;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "story")
public class Story {

    @Id
    private Long id;

    @Column(name = "title")
    private String title;

    @Column(name = "date")
    private String date;

    @Column(name = "emotion")
    private String emotion;

    @Column(name = "motivational_message")
    private String motivationalMessage;

    @Column(name = "text")
    private String text;
}
