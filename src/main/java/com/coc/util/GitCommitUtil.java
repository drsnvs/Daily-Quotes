package com.coc.util;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.File;
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
    
            // Update the quote file with a new daily quote
            // Add your logic to update the quote.txt file
    
            log.info("Quote updated. Git commit and push will be handled by GitHub Actions.");
        } catch (Exception e) {
            log.error("Error updating the quote: {}", e.getMessage(), e);
        }
    }
    

    // public void commitAndPushChanges() {
    //     try {
    //         String currentDate = LocalDate.now().format(DateTimeFormatter.ISO_LOCAL_DATE);
    //         String commitMessage = "Update daily quote - " + currentDate;
            
    //         // Windows doesn't use bash, so let's directly use git commands
    //         executeGitCommand("git add " + quoteFilePath);
    //         executeGitCommand("git commit -m \"" + commitMessage + "\"");
    //         executeGitCommand("git push");
            
    //         log.info("Git commit and push operations completed");
    //     } catch (IOException | InterruptedException e) {
    //         log.error("Error executing git command: {}", e.getMessage(), e);
    //         Thread.currentThread().interrupt();
    //     }
    // }
    // Windows
    // private void executeGitCommand(String command) throws IOException, InterruptedException {
    //     log.info("Executing git command: {}", command);
        
    //     ProcessBuilder processBuilder = new ProcessBuilder();
    //     processBuilder.command("cmd", "/c", command);
    //     processBuilder.redirectErrorStream(true);
        
    //     Process process = processBuilder.start();
        
    //     // Log the output of the command
    //     try (BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()))) {
    //         String line;
    //         while ((line = reader.readLine()) != null) {
    //             log.info("Git command output: {}", line);
    //         }
    //     }
        
    //     int exitCode = process.waitFor();
    //     if (exitCode != 0) {
    //         log.error("Git command failed with exit code: {}", exitCode);
    //     }
    // }
    
    // linux
    // private void executeGitCommand(String scriptPath) throws IOException, InterruptedException {
    //     File scriptFile = new File(scriptPath);
    
    //     if (!scriptFile.exists()) {
    //         log.error("Git script not found at path: {}", scriptFile.getAbsolutePath());
    //         return;
    //     }
    
    //     if (!scriptFile.isFile()) {
    //         log.error("Provided path is not a file: {}", scriptFile.getAbsolutePath());
    //         return;
    //     }
    
    //     File workingDir = scriptFile.getParentFile();
    //     log.info("Executing git script: {}", scriptFile.getAbsolutePath());
    //     log.info("Working directory set to: {}", workingDir.getAbsolutePath());
    
    //     ProcessBuilder processBuilder = new ProcessBuilder();
    //     processBuilder.command("bash", "-c", scriptFile.getAbsolutePath());
    //     processBuilder.directory(workingDir);
    //     processBuilder.redirectErrorStream(true);
    
    //     Process process = processBuilder.start();
    
    //     try (BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()))) {
    //         String line;
    //         while ((line = reader.readLine()) != null) {
    //             log.info("Git command output: {}", line);
    //         }
    //     }
    
    //     int exitCode = process.waitFor();
    //     if (exitCode != 0) {
    //         log.error("Git command failed with exit code: {}", exitCode);
    //     } else {
    //         log.info("Git command executed successfully.");
    //     }
    // }
    // private void executeGitCommand(String command) throws IOException, InterruptedException {
    //     File workingDir = new File("/app"); // Or your actual git repo root on Railway
    
    //     log.info("Executing command: {}", command);
    
    //     ProcessBuilder processBuilder = new ProcessBuilder("bash", "-c", command);
    //     processBuilder.directory(workingDir);
    //     processBuilder.redirectErrorStream(true);
    
    //     Process process = processBuilder.start();
    
    //     try (BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()))) {
    //         String line;
    //         while ((line = reader.readLine()) != null) {
    //             log.info("Git command output: {}", line);
    //         }
    //     }
    
    //     int exitCode = process.waitFor();
    //     if (exitCode != 0) {
    //         log.error("Git command failed with exit code: {}", exitCode);
    //     }
    // }
    
    
} 