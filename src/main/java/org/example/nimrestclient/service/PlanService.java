package org.example.nimrestclient.service;

import lombok.RequiredArgsConstructor;
import org.example.nimrestclient.dto.PlanFormDTO;
import org.example.nimrestclient.util.NimUtil;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class PlanService {
    private final NimUtil nimUtil;

    public String doPlan(PlanFormDTO dto) {
        String prompt = """
                %s에 대한 학습 계획을 2주치 마크다운 없이 간결하게 200자 이내로 세워줘.
                """.trim();
        return nimUtil.useNim(
                prompt.formatted(dto.subject())
        );
    }
}
