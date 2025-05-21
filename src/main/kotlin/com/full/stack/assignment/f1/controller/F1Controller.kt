package com.full.stack.assignment.f1.controller

import com.full.stack.assignment.f1.model.Season
import com.full.stack.assignment.f1.service.F1Service
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController
import java.lang.IllegalArgumentException

const val FIRST_FORMULA1_YEAR = 1950

class InvalidDateRangeException(message: String) : IllegalArgumentException(message)

@RestController
@RequestMapping("/api/v1/seasons")
class F1Controller(
    private val f1Service: F1Service
) {

    @ExceptionHandler(InvalidDateRangeException::class)
    fun handleBadRequest(e: InvalidDateRangeException): ResponseEntity<String> =
        ResponseEntity(e.message, HttpStatus.BAD_REQUEST)

    @GetMapping
    fun getSeasonsWithChampions(
        @RequestParam(name = "from", defaultValue = "2005") from: Int,
        @RequestParam(name = "to", required = false) to: Int?
    ): List<Season> {
        val to = to ?: java.time.Year.now().value
        if (from > to) throw InvalidDateRangeException(
            "From year ($from) cannot be greater than to year ($to)"
        )

        if(to < FIRST_FORMULA1_YEAR || from < FIRST_FORMULA1_YEAR) throw InvalidDateRangeException(
            "Invalid range. Range should start from year that is >= $FIRST_FORMULA1_YEAR"
        )

        return f1Service.getSeasons(from, to)
    }
}