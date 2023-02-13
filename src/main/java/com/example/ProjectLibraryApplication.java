package com.example;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.socket.config.annotation.EnableWebSocket;

@SpringBootApplication
@EnableScheduling
@MapperScan("com.example.mapper")
@EnableWebSocket
public class ProjectLibraryApplication {

	public static void main(String[] args) {
		SpringApplication.run(ProjectLibraryApplication.class, args);
	}

}
