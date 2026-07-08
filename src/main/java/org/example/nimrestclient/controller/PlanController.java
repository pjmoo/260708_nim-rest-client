package org.example.nimrestclient.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class PlanController {
    @GetMapping("/")
    public String page() {
        return "plan"; // view resolver <- 해석해줌
        // (/webapp)/WEB-INF/views/plan.jsp
    }
}
