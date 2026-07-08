package org.example.nimrestclient.util;

import org.springframework.stereotype.Component;

@Component
public class NimUtil {
    public String useNim(String prompt) {
        return "%s라니 멋지군요!".formatted(prompt);
    }
}
