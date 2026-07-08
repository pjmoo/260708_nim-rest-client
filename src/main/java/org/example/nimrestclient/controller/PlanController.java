package org.example.nimrestclient.controller;

import lombok.RequiredArgsConstructor;
import org.example.nimrestclient.dto.PlanFormDTO;
import org.example.nimrestclient.service.PlanService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/")
@RequiredArgsConstructor
public class PlanController {
    private final PlanService planService;

    @GetMapping("/")
    public String page() {
        return "plan"; // view resolver <- 해석해줌
        // (/webapp)/WEB-INF/views/plan.jsp
    }

    @PostMapping("/")
    public String form(
            @ModelAttribute PlanFormDTO dto,
            RedirectAttributes redirectAttributes) {
        String plan = planService.doPlan(dto);
//        String plan = "무언가 멋진 계획 : %s".formatted(dto.subject());
        // el에서 쓸 수 있는 requestScope로 전달
        redirectAttributes.addFlashAttribute("plan", plan);
        return "redirect:/"; // redirect는 model X.
    }
}
