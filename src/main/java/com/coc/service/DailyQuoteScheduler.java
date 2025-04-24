package com.coc.service;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class DailyQuoteScheduler {

    private final QuoteService quoteService;
    private final FileService fileService;

    public DailyQuoteScheduler(QuoteService quoteService, FileService fileService) {
        this.quoteService = quoteService;
        this.fileService = fileService;
    }

    @Scheduled(cron = "0 0 9 * * *")
    public void fetchAndSaveQuote() throws IOException {
        String quote = quoteService.getDailyQuote();
        fileService.writeToFile(quote);
    }
}

