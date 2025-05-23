package com.full.stack.assignment.f1.data.remote.model

import com.fasterxml.jackson.annotation.JsonProperty
import com.full.stack.assignment.f1.model.Driver

data class DriverStandingResponseDTO(
    @JsonProperty("MRData")
    val driverStandingsData: DriverStandingDataDTO,
)

data class DriverStandingDataDTO(
    @JsonProperty("StandingsTable")
    val standingsTable: StandingsTableDTO,
)

data class StandingsTableDTO(
    @JsonProperty("StandingsLists")
    val standingsList: List<SeasonRoundDTO>,
)

data class SeasonRoundDTO(
    @JsonProperty("round")
    val round: Int,
    @JsonProperty("DriverStandings")
    val driverStandings: List<DriverStandingDTO>,
)

data class DriverStandingDTO(
    @JsonProperty("position")
    val position: Int,
    @JsonProperty("points")
    val points: Double,
    @JsonProperty("wins")
    val wins: Int,
    @JsonProperty("Driver")
    val driver: Driver,
)
