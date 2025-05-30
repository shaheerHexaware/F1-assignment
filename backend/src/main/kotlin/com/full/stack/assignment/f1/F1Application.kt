package com.full.stack.assignment.f1

import com.full.stack.assignment.f1.service.OnStartDataInitializationService
import org.springframework.boot.CommandLineRunner
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.boot.web.client.RestTemplateBuilder
import org.springframework.context.annotation.Bean
import org.springframework.web.client.RestTemplate

@SpringBootApplication
class F1Application {
    @Bean
    fun restTemplate(builder: RestTemplateBuilder): RestTemplate = builder.build()

    @Bean
    fun initializeData(initializationService: OnStartDataInitializationService): CommandLineRunner {
        return CommandLineRunner {
            initializationService.initializeF1Data()
        }
    }
}

fun main(args: Array<String>) {
    runApplication<F1Application>(*args)
}
