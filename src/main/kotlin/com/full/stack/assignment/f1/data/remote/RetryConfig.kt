package com.full.stack.assignment.f1.data.remote

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.retry.annotation.EnableRetry
import org.springframework.retry.backoff.ExponentialBackOffPolicy
import org.springframework.retry.policy.SimpleRetryPolicy
import org.springframework.retry.support.RetryTemplate

@Configuration
@EnableRetry
class RetryConfig {
    
    @Bean
    fun retryTemplate(): RetryTemplate {
        val retryTemplate = RetryTemplate()
        
        val exponentialBackOffPolicy = ExponentialBackOffPolicy().apply {
            initialInterval = 1000L
            multiplier = 2.0
            maxInterval = 15000L
        }
        
        val retryPolicy = SimpleRetryPolicy().apply {
            maxAttempts = 5
        }
        
        retryTemplate.setBackOffPolicy(exponentialBackOffPolicy)
        retryTemplate.setRetryPolicy(retryPolicy)
        
        return retryTemplate
    }
}