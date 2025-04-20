package com.coc.controller;

import com.coc.service.QuoteService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@Slf4j
public class QuoteController {

    private final QuoteService quoteService;
    
    @Value("${quote.time.start-hour:6}")
    private int startHour;
    
    @Value("${quote.time.end-hour:7}")
    private int endHour;

    @Autowired
    public QuoteController(QuoteService quoteService) {
        this.quoteService = quoteService;
    }

    @GetMapping("/quote")
    @ResponseBody
    public ResponseEntity<String> getQuote() {
        log.info("Received request for /quote");
        String quote = quoteService.readQuoteFromFile();
        return ResponseEntity.ok(quote);
    }
    
    @GetMapping("/")
    public String home(Model model) {
        log.info("Received request for home page");
        String quote = quoteService.readQuoteFromFile();
        model.addAttribute("quote", quote);
        model.addAttribute("startHour", startHour);
        model.addAttribute("endHour", endHour);
        return "home";
    }
} 