package org.example.nimrestclient.util;

import org.example.nimrestclient.dto.NimRequestDTO;
import org.example.nimrestclient.dto.NimResponseDTO;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;

@Component
public class NimUtil {
    private final String nimApiKey = System.getenv("NIM_API_KEY");
    private final String nimApiURL = "https://integrate.api.nvidia.com/v1/chat/completions";
    private final RestClient restClient;

    protected NimUtil() {
        if (nimApiKey == null || nimApiKey.trim().isEmpty()) {
            System.err.println("WARNING: NIM_API_KEY environment variable is not set. Using fallback mode.");
            this.restClient = null;
        } else {
            String maskedKey = nimApiKey.length() > 10 ? nimApiKey.substring(0, 10) + "..." : "invalid_key";
            System.out.println("nimApiKey initialized: " + maskedKey);
            this.restClient = RestClient.builder()
                    .baseUrl(nimApiURL)
                    .defaultHeader("Authorization", "Bearer %s".formatted(nimApiKey))
                    .defaultHeader("Content-Type", "application/json")
                    .build();
        }
    }

    public String useNim(String prompt) {
        if (nimApiKey == null || nimApiKey.trim().isEmpty() || restClient == null) {
            return "⚠️ **NIM_API_KEY** 환경 변수가 설정되지 않았습니다.\n" +
                   "프로젝트 루트의 `.env` 파일에 발급받은 API 키를 작성해 주세요.\n\n" +
                   "**[데모용 2주 학습 계획]**\n" +
                   "• **1주차**: 대상 과목의 핵심 개념 이해, 기본 원리 학습 및 실습 환경 구축\n" +
                   "• **2주차**: 소규모 미니 프로젝트 구현, 디버깅 실습 및 최종 복습";
        }

        String model = "deepseek-ai/deepseek-v4-flash";
        try {
            NimResponseDTO response = restClient.post()
                    .body(NimRequestDTO.of(model, prompt))
                    .retrieve()
                    .body(NimResponseDTO.class);
            System.out.println("response = " + response);
            if (response != null) {
                return response.getResult();
            }
            return "응답이 비어있습니다.";
        } catch (Exception e) {
            System.err.println("API 호출 중 오류 발생: " + e.getMessage());
            return "NIM API 호출 실패: " + e.getMessage();
        }
    }
}
