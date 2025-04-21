package com.coc.scheduler;

import com.coc.model.Quote;
import com.coc.service.QuoteService;
import com.coc.util.GitCommitUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class DailyQuoteTask {

    private final QuoteService quoteService;
    private final GitCommitUtil gitCommitUtil;
    
    @Value("${git.enabled:true}")
    private boolean gitEnabled;

    public DailyQuoteTask(QuoteService quoteService, GitCommitUtil gitCommitUtil) {
        this.quoteService = quoteService;
        this.gitCommitUtil = gitCommitUtil;
    }

    @Scheduled(cron = "${quote.schedule.cron}")
    public void fetchAndSaveQuoteDaily() {
        log.info("Starting scheduled task to fetch and save daily quote");
        
        try {
            // Fetch quote
            Quote quote = quoteService.fetchDailyQuote();
            
            // Save quote to file
            quoteService.saveQuoteToFile(quote);
            
            // Commit and push changes if enabled
            if (gitEnabled) {
                gitCommitUtil.commitAndPushChanges();
            } else {
                log.info("Git auto-commit is disabled");
            }
            
            log.info("Scheduled task completed successfully");
        } catch (Exception e) {
            log.error("Error in scheduled task: {}", e.getMessage(), e);
        }
    }

    @Scheduled(cron = "0 07 23 * * ?")
public void runTask() {
    System.out.println(">>>> Scheduled task triggered");
    log.info(">>>> Logging from scheduled task");
} 