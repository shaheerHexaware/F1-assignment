package com.full.stack.assignment.f1.data.remote

import com.full.stack.assignment.f1.data.remote.model.DriverStandingResponseDTO
import com.full.stack.assignment.f1.data.remote.model.RaceDTO
import com.full.stack.assignment.f1.data.remote.model.SeasonRacesResponseDTO
import com.full.stack.assignment.f1.model.Race
import com.full.stack.assignment.f1.model.Season
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Repository
import org.springframework.web.client.RestClientException
import org.springframework.web.util.UriComponentsBuilder

@Repository
class RemoteRepository(
    @Value("\${api.base.url}") private val baseUrl: String,
    private val apiClient: ApiClient,
) {
    fun getSeason(year: Int): Season {
        val url = UriComponentsBuilder.fromUriString(baseUrl)
            .pathSegment(year.toString(), DRIVER_STANDINGS)
            .build()
            .toUriString()

        val response = apiClient.callApi(url, DriverStandingResponseDTO::class.java)

        if (response.statusCode.isError) throw RestClientException("Error retrieving season $year")

        val winningDriver =
            response.body?.driverStandingsData?.standingsTable?.standingsList?.firstOrNull()?.driverStandings?.find { it.position == 1 }
                ?: throw IllegalStateException("Unable to find winning driver for year $year")
        return Season(
            year = year,
            champion = winningDriver.driver
        )
    }

    fun getSeasonRaces(year: Int): List<Race> {
        val allResults = mutableListOf<RaceDTO>()
        var offset = 0
        var total = Int.MAX_VALUE

        while (offset < total) {
            val url = UriComponentsBuilder.fromUriString(baseUrl)
                .pathSegment(year.toString(), RESULTS_PATH)
                .queryParam(LIMIT_PARAM, LIMIT)
                .queryParam(OFFSET_PARAM, offset)
                .build()
                .toUriString()

            val response = apiClient.callApi(url, SeasonRacesResponseDTO::class.java)

            if (response.statusCode.isError) throw RestClientException("Error retrieving races for season $year")

            total = response.body?.seasonRacesPagedData?.total?: Int.MAX_VALUE

            allResults += response.body?.seasonRacesPagedData?.raceTable?.races?: emptyList()

            offset += LIMIT
        }

        return allResults
            .groupBy { it.round }
            .map { (round, groupedData) ->
                val winningPosition = groupedData.flatMap { it.results }.find{ it.position == 1}
                    ?: throw RestClientException("Error retrieving winning driver for race $round")

                val raceData = groupedData.first()

                Race(
                    seasonYear = raceData.season,
                    round = raceData.round,
                    raceName = raceData.raceName,
                    circuit = raceData.circuit,
                    date = raceData.date,
                    winningDriver = winningPosition.driver,
                    winningConstructor = winningPosition.constructor
                )
            }
    }

    companion object{
        const val DRIVER_STANDINGS = "driverstandings"
        const val RESULTS_PATH = "results"
        const val LIMIT_PARAM = "limit"
        const val OFFSET_PARAM = "offset"
        const val LIMIT = 100
    }
}