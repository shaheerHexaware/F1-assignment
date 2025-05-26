package com.full.stack.assignment.f1

import com.full.stack.assignment.f1.controller.F1Controller
import org.springframework.beans.factory.annotation.Value
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
    fun initializeData(
        f1Controller: F1Controller,
        @Value("\${data.initializer.start.year}") startYear: Int,
        @Value("\${data.initializer.end.year}") endYear: Int? = null,
    ): CommandLineRunner {
        return CommandLineRunner {
            f1Controller.getSeasonsWithChampions(startYear, endYear)
        }
    }
}

fun main(args: Array<String>) {
    runApplication<F1Application>(*args)
}
