package com.admantic.MonProjetWeb;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class HelloController {

    @RequestMapping("/erreur")
    public String index() {
        return "Page erreur du projet";
    }

}

