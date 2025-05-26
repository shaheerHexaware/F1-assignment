package com.full.stack.assignment.f1.data.remote

import io.github.resilience4j.ratelimiter.annotation.RateLimiter
import io.github.resilience4j.retry.annotation.Retry
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Component
import org.springframework.web.client.HttpClientErrorException
import org.springframework.web.client.RestTemplate

class RateLimitExceededException(message: String?, cause: Throwable?) : RuntimeException(message, cause)

@Component
class ApiClient(
    private val restTemplate: RestTemplate,
) {
    @RateLimiter(name = "default")
    @Retry(name = "default", fallbackMethod = "getDataFallback")
    fun <ResponseDTO> callApi(
        url: String,
        responseType: Class<ResponseDTO>,
    ): ResponseEntity<ResponseDTO> {
        return try {
            restTemplate.getForEntity(url, responseType)
        } catch (ex: HttpClientErrorException) {
            println(ex)
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
        return ResponseEntity.notFound().build<ResponseDTO>()
    }
}
