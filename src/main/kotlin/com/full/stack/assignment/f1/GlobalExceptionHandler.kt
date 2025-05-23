package com.full.stack.assignment.f1

import com.full.stack.assignment.f1.data.remote.RateLimitExceededException
import jakarta.validation.ConstraintViolationException
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.ControllerAdvice
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.client.RestClientException
import java.lang.IllegalArgumentException

class InvalidDateRangeException(message: String) : IllegalArgumentException(message)

@ControllerAdvice
class GlobalExceptionHandler {
    @ExceptionHandler(RestClientException::class)
    fun handleInternalErrorRequest(e: RestClientException): ResponseEntity<String> =
        ResponseEntity(e.message, HttpStatus.INTERNAL_SERVER_ERROR)

    @ExceptionHandler(RateLimitExceededException::class)
    fun handleInternalErrorRequest(e: RateLimitExceededException): ResponseEntity<String> =
        ResponseEntity(e.message, HttpStatus.TOO_MANY_REQUESTS)

    @ExceptionHandler(InvalidDateRangeException::class)
    fun handleBadRequest(e: InvalidDateRangeException): ResponseEntity<ApiError> {
        val error = ApiError(listOf(e.message ?: "Invalid Date Range."))
        return ResponseEntity(error, HttpStatus.BAD_REQUEST)
    }

    @ExceptionHandler(ConstraintViolationException::class)
    fun handleConstraintViolationException(e: ConstraintViolationException): ResponseEntity<ApiError> {
        val errors = e.constraintViolations.map { it.message }
        return ResponseEntity
            .status(HttpStatus.BAD_REQUEST)
            .body(ApiError(errors))
    }

    data class ApiError(val errors: List<String>)
}
