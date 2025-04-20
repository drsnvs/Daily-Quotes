package com.coc.service;

import com.coc.model.Quote;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;

@Service
@Slf4j
public class QuoteService {

    @Value("${quote.api.url}")
    private String quoteApiUrl;

    @Value("${quote.file.path}")
    private String quoteFilePath;

    private final RestTemplate restTemplate;

    public QuoteService() {
        this.restTemplate = new RestTemplate();
    }

    public Quote fetchDailyQuote() {
        try {
            log.info("Fetching quote from API: {}", quoteApiUrl);
            Quote[] quotes = restTemplate.getForObject(quoteApiUrl, Quote[].class);
            
            if (quotes != null && quotes.length > 0) {
                Quote quote = quotes[0];
                log.info("Successfully fetched quote: {}", quote);
                return quote;
            } else {
                log.error("No quotes returned from API");
                return new Quote("Failed to fetch quote", "System");
            }
        } catch (Exception e) {
            log.error("Error fetching quote: {}", e.getMessage(), e);
            return new Quote("Failed to fetch quote", "System");
        }
    }

    public void saveQuoteToFile(Quote quote) {
        try {
            Path path = Paths.get(quoteFilePath);
            Files.writeString(path, quote.toString(), StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);
            log.info("Quote saved to file: {}", quoteFilePath);
        } catch (IOException e) {
            log.error("Error saving quote to file: {}", e.getMessage(), e);
        }
    }

    public String readQuoteFromFile() {
        try {
            Path path = Paths.get(quoteFilePath);
            if (!Files.exists(path)) {
                log.warn("Quote file does not exist: {}", quoteFilePath);
                return "No quote available yet";
            }
            
            String quote = Files.readString(path);
            log.info("Read quote from file: {}", quote);
            return quote;
        } catch (IOException e) {
            log.error("Error reading quote from file: {}", e.getMessage(), e);
            return "Error retrieving quote";
        }
    }
} 