package com.admantic.MonProjetWeb;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class HelloController {

    @RequestMapping("/index")
    public String index() {
        return "page index du projet";
    }

}

