package com.full.stack.assignment.f1.controller

import com.full.stack.assignment.f1.InvalidDateRangeException
import com.full.stack.assignment.f1.controller.validators.MaxCurrentYear
import com.full.stack.assignment.f1.model.Race
import com.full.stack.assignment.f1.model.Season
import com.full.stack.assignment.f1.service.F1Service
import jakarta.validation.constraints.Min
import org.springframework.validation.annotation.Validated
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController

const val FIRST_FORMULA1_YEAR = 1950

@RestController
@RequestMapping("/api/v1/seasons")
@Validated
class F1Controller(
    private val f1Service: F1Service,
) {
    @GetMapping
    fun getSeasonsWithChampions(
        @RequestParam(name = "from", defaultValue = "2005")
        @Min(value = FIRST_FORMULA1_YEAR.toLong(), message = "Invalid year. `from` year should be >= $FIRST_FORMULA1_YEAR")
        from: Int,
        @RequestParam(name = "to", required = false)
        @Min(value = FIRST_FORMULA1_YEAR.toLong(), message = "Invalid year. `to` year should be >= $FIRST_FORMULA1_YEAR")
        @MaxCurrentYear(message = "Invalid year. `to` year should be <= current year")
        to: Int?,
    ): List<Season> {
        val currentYear = java.time.Year.now().value
        val to = to ?: currentYear
        if (from > to) {
            throw InvalidDateRangeException(
                "`from` year ($from) cannot be greater than `to` year ($to)",
            )
        }

        return f1Service.getSeasons(from, to)
    }

    @GetMapping(path = ["/{year}/races"])
    fun getSeasonRaces(
        @PathVariable
        @Min(value = FIRST_FORMULA1_YEAR.toLong(), message = "Invalid year. Year should be >= $FIRST_FORMULA1_YEAR")
        @MaxCurrentYear(message = "Invalid year. `to` year should be <= current year")
        year: Int,
    ): List<Race> {
        return f1Service.getSeasonRaces(year)
    }
}
