package com.full.stack.assignment.f1.data.remote

import org.springframework.http.ResponseEntity
import org.springframework.retry.support.RetryTemplate
import org.springframework.stereotype.Component
import org.springframework.web.client.HttpClientErrorException
import org.springframework.web.client.RestTemplate

class RateLimitExceededException(message: String?, cause: Throwable?) : RuntimeException(message, cause)

@Component
class ApiClient(
    private val restTemplate: RestTemplate,
    private val retryTemplate: RetryTemplate
) {
    fun <ResponseDTO> callApi(url: String, responseType: Class<ResponseDTO>): ResponseEntity<ResponseDTO> {
        return retryTemplate.execute<ResponseEntity<ResponseDTO>, Exception> {
            try {
                restTemplate.getForEntity(url, responseType)
            } catch (ex: HttpClientErrorException) {
                println(ex)
                if (ex.statusCode.value() == 429) {
                    throw RateLimitExceededException("Rate limit exceeded", ex)
                }
                throw ex
            }
        }
    }
}