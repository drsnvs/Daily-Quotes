package com.coc.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Quote {
    @JsonProperty("q")
    private String text;
    
    @JsonProperty("a")
    private String author;
    
    @Override
    public String toString() {
        return "\"" + text + "\" — " + author;
    }
} 