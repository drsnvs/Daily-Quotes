package com.coc.util;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Component
@Slf4j
public class GitCommitUtil {

    @Value("${git.script.path}")
    private String gitScriptPath;
    
    @Value("${quote.file.path}")
    private String quoteFilePath;

    public void commitAndPushChanges() {
        try {
            String currentDate = LocalDate.now().format(DateTimeFormatter.ISO_LOCAL_DATE);
            String commitMessage = "Update daily quote - " + currentDate;
            
            // Windows doesn't use bash, so let's directly use git commands
            executeGitCommand("git add " + quoteFilePath);
            executeGitCommand("git commit -m \"" + commitMessage + "\"");
            executeGitCommand("git push");
            
            log.info("Git commit and push operations completed");
        } catch (IOException | InterruptedException e) {
            log.error("Error executing git command: {}", e.getMessage(), e);
            Thread.currentThread().interrupt();
        }
    }
    
    private void executeGitCommand(String command) throws IOException, InterruptedException {
        log.info("Executing git command: {}", command);
        
        ProcessBuilder processBuilder = new ProcessBuilder();
        processBuilder.command("cmd", "/c", command);
        processBuilder.redirectErrorStream(true);
        
        Process process = processBuilder.start();
        
        // Log the output of the command
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()))) {
            String line;
            while ((line = reader.readLine()) != null) {
                log.info("Git command output: {}", line);
            }
        }
        
        int exitCode = process.waitFor();
        if (exitCode != 0) {
            log.error("Git command failed with exit code: {}", exitCode);
        }
    }
} 