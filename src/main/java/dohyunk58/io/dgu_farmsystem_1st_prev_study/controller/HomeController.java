package dohyunk58.io.dgu_farmsystem_1st_prev_study.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    @GetMapping("/")
    public String index() {
        return "index.html";
    }
}
