package com.full.stack.assignment.f1.data.remote.logger

import io.github.resilience4j.ratelimiter.RateLimiterRegistry
import io.github.resilience4j.ratelimiter.event.RateLimiterEvent
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.InitializingBean
import org.springframework.context.annotation.Configuration

@Configuration
class RateLimiterEventLogger(private val rateLimiterRegistry: RateLimiterRegistry) : InitializingBean {
    companion object {
        const val RATE_LIMITER_ID = "default"
    }

    private val logger: Logger = LoggerFactory.getLogger(RateLimiterEventLogger::class.java)

    override fun afterPropertiesSet() {
        val rateLimiter = rateLimiterRegistry.rateLimiter(RATE_LIMITER_ID)
        rateLimiter.eventPublisher
            .onSuccess { event -> logSuccessEvent(event) }
            .onFailure { event -> logFailureEvent(event) }
        logger.info("Registered event handlers for rateLimiter $RATE_LIMITER_ID")
    }

    private fun logSuccessEvent(event: RateLimiterEvent) {
        logger.info("RateLimiter success: ${event.rateLimiterName}")
    }

    private fun logFailureEvent(event: RateLimiterEvent) {
        logger.warn("RateLimiter failure: ${event.rateLimiterName}")
    }
}
