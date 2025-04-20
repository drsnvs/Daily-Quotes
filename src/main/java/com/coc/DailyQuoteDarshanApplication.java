package com.coc;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class DailyQuoteDarshanApplication {

	public static void main(String[] args) {
		SpringApplication.run(DailyQuoteDarshanApplication.class, args);
	}

}
