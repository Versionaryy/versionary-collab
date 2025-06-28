package com.versionary.post_service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@EnableEurekaClient
@SpringBootApplication
public class PostServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(PostServiceApplication.class, args);
	}

}
