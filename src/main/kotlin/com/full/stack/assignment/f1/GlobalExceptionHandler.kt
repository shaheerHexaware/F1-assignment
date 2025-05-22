package com.full.stack.assignment.f1

import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.ControllerAdvice
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.client.RestClientException
import java.lang.IllegalArgumentException

class InvalidDateRangeException(message: String) : IllegalArgumentException(message)

@ControllerAdvice
class GlobalExceptionHandler {

    @ExceptionHandler(InvalidDateRangeException::class)
    fun handleBadRequest(e: InvalidDateRangeException): ResponseEntity<String> =
        ResponseEntity(e.message, HttpStatus.BAD_REQUEST)

    @ExceptionHandler(RestClientException::class)
    fun handleInternalErrorRequest(e: RestClientException): ResponseEntity<String> =
        ResponseEntity(e.message, HttpStatus.INTERNAL_SERVER_ERROR)
}