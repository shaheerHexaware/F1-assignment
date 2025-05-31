package com.full.stack.assignment.f1.data.remote

import com.full.stack.assignment.f1.data.remote.logger.RateLimiterEventLogger
import com.full.stack.assignment.f1.data.remote.logger.RetryEventLogger
import io.github.resilience4j.ratelimiter.annotation.RateLimiter
import io.github.resilience4j.retry.annotation.Retry
import org.slf4j.LoggerFactory
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Component
import org.springframework.web.client.HttpClientErrorException
import org.springframework.web.client.RestTemplate

class RateLimitExceededException(message: String?, cause: Throwable?) : RuntimeException(message, cause)

@Component
class ApiClient(
    private val restTemplate: RestTemplate,
) {
    private val logger = LoggerFactory.getLogger(javaClass)

    @RateLimiter(name = RateLimiterEventLogger.RATE_LIMITER_ID)
    @Retry(name = RetryEventLogger.RETRY_ID, fallbackMethod = "getDataFallback")
    fun <ResponseDTO> callApi(
        url: String,
        responseType: Class<ResponseDTO>,
    ): ResponseEntity<ResponseDTO> {
        return try {
            restTemplate.getForEntity(url, responseType)
        } catch (ex: HttpClientErrorException) {
            logger.error("Error while calling API: $url. Status code: ${ex.statusCode}. Exception: ${ex.message}")
            if (ex.statusCode.value() == 429) {
                throw RateLimitExceededException("Rate limit exceeded", ex)
            }
            throw ex
        }
    }

    fun <ResponseDTO> getDataFallback(
        url: String,
        responseType: Class<ResponseDTO>,
        throwable: Throwable,
    ): ResponseEntity<ResponseDTO> {
        println("Fallback triggered for URL: $url. Exception: ${throwable.message}")
        return ResponseEntity.status(HttpStatus.TOO_MANY_REQUESTS).body(null)
    }
}
