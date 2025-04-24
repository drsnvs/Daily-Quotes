package com.coc.controller;
//
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//
//import java.io.IOException;
//import java.nio.file.Files;
//import java.nio.file.Paths;
//
//@Controller
//public class ViewController {
//
//    @Value("${quote.file.path}")
//    private String filePath;
//
//    @GetMapping("/")
//    public String viewQuote(Model model) throws IOException {
//        String quote = new String(Files.readAllBytes(Paths.get(filePath)));
//        model.addAttribute("quote", quote);
//        return "quote";
//    }
//}
//
