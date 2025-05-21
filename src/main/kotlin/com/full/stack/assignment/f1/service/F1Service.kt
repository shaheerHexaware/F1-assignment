package com.full.stack.assignment.f1.service

import com.full.stack.assignment.f1.model.Race
import com.full.stack.assignment.f1.model.Season

interface F1Service {
    fun getSeasons(
        from: Int,
        to: Int
    ): List<Season>

    fun getSeasonRaces(
        season: Int
    ): List<Race>
}