package org.example.nimrestclient.dto;

import java.util.List;

public record NimRequestDTO(String model,
                            List<Message> messages) {
    record Message(String role, String content) {
    }
    
    public static NimRequestDTO of(String model, String prompt) {
        return new NimRequestDTO(model, List.of(new Message("user", prompt)));
    }
}
