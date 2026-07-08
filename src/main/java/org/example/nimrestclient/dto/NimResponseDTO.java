package org.example.nimrestclient.dto;

import java.util.List;

// https://jsonformatter.org/
public record NimResponseDTO(List<Choice> choices) {
    record Choice(Message message) {
    }

    record Message(String content) {
    }

    public String getResult() {
        return choices.get(0).message.content;
    }
}
