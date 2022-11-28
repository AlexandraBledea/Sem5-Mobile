package com.example.journal.dto;


import lombok.*;

import javax.persistence.Column;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@EqualsAndHashCode
public class StoryDTO {

    private Long id;

    private String title;

    private String date;

    private String emotion;

    private String motivationalMessage;

    private String text;
}
