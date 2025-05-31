package com.full.stack.assignment.f1.data.remote.logger

import io.github.resilience4j.retry.RetryRegistry
import io.github.resilience4j.retry.event.RetryEvent
import io.github.resilience4j.retry.event.RetryOnRetryEvent
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.InitializingBean
import org.springframework.stereotype.Component

@Component
class RetryEventLogger(private val retryRegistry: RetryRegistry) : InitializingBean {
    companion object {
        const val RETRY_ID = "default"
    }

    private val logger = LoggerFactory.getLogger(RetryEventLogger::class.java)

    override fun afterPropertiesSet() {
        val retry = retryRegistry.retry(RETRY_ID)

        retry.eventPublisher
            .onRetry(this::logRetryEvent)
            .onSuccess(this::logSuccessEvent)
            .onError(this::logErrorEvent)

        logger.info("Registered event handlers for retry $RETRY_ID")
    }

    private fun logRetryEvent(event: RetryOnRetryEvent) {
        logger.debug("Retry attempt #${event.numberOfRetryAttempts} for ${event.name}. Waiting ${event.waitInterval.toMillis()} ms")
    }

    private fun logErrorEvent(event: RetryEvent) {
        logger.error("Retry failed after ${event.numberOfRetryAttempts} attempts for ${event.name}. Error: ${event.lastThrowable.message}")
    }

    private fun logSuccessEvent(event: RetryEvent) {
        logger.info("Retry succeeded after ${event.numberOfRetryAttempts} attempts for ${event.name}")
    }
}
