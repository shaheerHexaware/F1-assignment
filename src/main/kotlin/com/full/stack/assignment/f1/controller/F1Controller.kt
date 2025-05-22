package com.full.stack.assignment.f1.controller

import com.full.stack.assignment.f1.InvalidDateRangeException
import com.full.stack.assignment.f1.model.Race
import com.full.stack.assignment.f1.model.Season
import com.full.stack.assignment.f1.service.F1Service
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController

const val FIRST_FORMULA1_YEAR = 1950

@RestController
@RequestMapping("/api/v1/seasons")
class F1Controller(
    private val f1Service: F1Service
) {

    @GetMapping
    fun getSeasonsWithChampions(
        @RequestParam(name = "from", defaultValue = "2005") from: Int,
        @RequestParam(name = "to", required = false) to: Int?
    ): List<Season> {
        val currentYear = java.time.Year.now().value
        val to = to ?: currentYear

        if(to > currentYear) throw InvalidDateRangeException(
            "To year ($to) cannot be greater than ($currentYear)"
        )
        if (from > to) throw InvalidDateRangeException(
            "From year ($from) cannot be greater than to year ($to)"
        )

        if(to < FIRST_FORMULA1_YEAR || from < FIRST_FORMULA1_YEAR) throw InvalidDateRangeException(
            "Invalid range. Range should start from year that is >= $FIRST_FORMULA1_YEAR"
        )

        return f1Service.getSeasons(from, to)
    }

    @GetMapping(path = ["/{year}/races"])
    fun getSeasonRaces(
        @PathVariable year: Int
    ): List<Race> {
        val currentYear = java.time.Year.now().value
        if(year > currentYear) throw InvalidDateRangeException(
            "Year ($year) cannot be greater than ($currentYear)"
        )
        if(year < FIRST_FORMULA1_YEAR) throw InvalidDateRangeException(
            "Invalid year. Year should be >= $FIRST_FORMULA1_YEAR"
        )
        return f1Service.getSeasonRaces(year)
    }
}