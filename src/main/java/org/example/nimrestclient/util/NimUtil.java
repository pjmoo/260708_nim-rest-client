package org.example.nimrestclient.util;

import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;

@Component
public class NimUtil {
    private final String nimApiKey = System.getenv("NIM_API_KEY");
    private final String nimApiURL = "https://integrate.api.nvidia.com/v1/chat/completions";
    private final RestClient restClient;

    protected NimUtil() {
        System.out.println("nimApiKey: " + nimApiKey.substring(0, 10) + "...");
        restClient = RestClient.builder()
                .baseUrl(nimApiURL)
                .defaultHeader("Authorization", "Bearer %s".formatted(nimApiKey))
                .defaultHeader("Content-Type", "application/json")
                .build();
    }

    public String useNim(String prompt) {
        return "%s라니 멋지군요!".formatted(prompt);
    }
}
