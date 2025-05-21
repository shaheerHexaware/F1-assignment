package com.full.stack.assignment.f1.data.remote.model

import com.fasterxml.jackson.annotation.JsonProperty
import com.full.stack.assignment.f1.model.Circuit
import com.full.stack.assignment.f1.model.Constructor
import com.full.stack.assignment.f1.model.Driver

data class SeasonRacesResponseDTO(
    @JsonProperty("MRData")
    val seasonRacesPagedData: SeasonRacesPagedDataDTO
)

data class SeasonRacesPagedDataDTO(
    @JsonProperty("limit")
    val limit: Int,
    @JsonProperty("offset")
    val offset: Int,
    @JsonProperty("total")
    val total: Int,
    @JsonProperty("RaceTable")
    val raceTable: RaceTableDTO
)

data class RaceTableDTO(
    @JsonProperty("season")
    val season: Int,
    @JsonProperty("Races")
    val races: List<RaceDTO>
)

data class RaceDTO(
    @JsonProperty("season")
    val season: Int,
    @JsonProperty("round")
    val round: Int,
    @JsonProperty("raceName")
    val raceName: String,
    @JsonProperty("Circuit")
    val circuit: Circuit,
    @JsonProperty("date")
    val date: String,
    @JsonProperty("Results")
    val results: List<DriverPositionDTO>
)

data class DriverPositionDTO(
    @JsonProperty("number")
    val number: Int,
    @JsonProperty("position")
    val position: Int,
    @JsonProperty("points")
    val points: Double,
    @JsonProperty("Driver")
    val driver: Driver,
    @JsonProperty("Constructor")
    val constructor: Constructor,
    @JsonProperty("grid")
    val grid: Int,
    @JsonProperty("laps")
    val laps: Int,
    @JsonProperty("status")
    val status: String
)