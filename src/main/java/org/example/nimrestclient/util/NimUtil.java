package org.example.nimrestclient.util;

import org.springframework.stereotype.Component;

@Component
public class NimUtil {
    private final String nimApiKey = System.getenv("NIM_API_KEY");

    NimUtil() {
        System.out.println("nimApiKey: " + nimApiKey.substring(0, 10) + "...");
    }

    public String useNim(String prompt) {
        return "%s라니 멋지군요!".formatted(prompt);
    }
}
