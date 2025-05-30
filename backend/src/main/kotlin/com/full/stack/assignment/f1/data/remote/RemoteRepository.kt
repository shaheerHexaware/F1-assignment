package com.full.stack.assignment.f1.data.remote

import com.full.stack.assignment.f1.data.remote.model.DriverStandingResponseDTO
import com.full.stack.assignment.f1.data.remote.model.RaceDTO
import com.full.stack.assignment.f1.data.remote.model.SeasonRacesResponseDTO
import com.full.stack.assignment.f1.model.Race
import com.full.stack.assignment.f1.model.Season
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Repository
import org.springframework.web.client.RestClientException
import org.springframework.web.util.UriComponentsBuilder

@Repository
class RemoteRepository(
    @Value("\${api.base.url}") private val baseUrl: String,
    private val apiClient: ApiClient,
) {
    private val logger = LoggerFactory.getLogger(RemoteRepository::class.java)

    fun getSeason(year: Int): Season {
        logger.debug("Fetching season data for year: $year from API")
        val url =
            UriComponentsBuilder.fromUriString(baseUrl)
                .pathSegment(year.toString(), DRIVER_STANDINGS)
                .build()
                .toUriString()

        val response = apiClient.callApi(url, DriverStandingResponseDTO::class.java)

        if (response.statusCode.isError) {
            logger.warn("Failed to retrieve season data for year $year from API with error code: ${response.statusCode}")
            throw RestClientException("Failed retrieving season $year with error code: ${response.statusCode}")
        }

        val winningDriver =
            response.body?.driverStandingsData?.standingsTable?.standingsList?.firstOrNull()?.driverStandings?.find { it.position == 1 }
                ?: run {
                    logger.warn("No winning driver found for year $year")
                    throw IllegalStateException("Unable to find winning driver for year $year")
                }
        logger.debug("Successfully retrieved season data for year: $year from API")
        return Season(
            year = year,
            champion = winningDriver.driver,
        )
    }

    fun getSeasonRaces(year: Int): List<Race> {
        logger.debug("Fetching races for season: $year from API")
        val allResults = mutableListOf<RaceDTO>()
        var offset = 0
        var total = Int.MAX_VALUE

        while (offset < total) {
            val url =
                UriComponentsBuilder.fromUriString(baseUrl)
                    .pathSegment(year.toString(), RESULTS_PATH)
                    .queryParam(LIMIT_PARAM, LIMIT)
                    .queryParam(OFFSET_PARAM, offset)
                    .build()
                    .toUriString()

            val response = apiClient.callApi(url, SeasonRacesResponseDTO::class.java)

            if (response.statusCode.isError) {
                logger.warn("Failed to retrieve races for season $year")
                throw RestClientException("Error retrieving races for season $year")
            }

            total = response.body?.seasonRacesPagedData?.total ?: Int.MAX_VALUE

            allResults += response.body?.seasonRacesPagedData?.raceTable?.races ?: emptyList()

            offset += LIMIT
        }

        logger.debug("Successfully retrieved ${allResults.size} races for season: $year from API")
        return allResults
            .groupBy { it.round }
            .map { (round, groupedData) ->
                val winningPosition =
                    groupedData.flatMap { it.results }.find { it.position == 1 }
                        ?: run{
                            logger.warn("No winning driver found for race $round")
                            throw RestClientException("Error retrieving winning driver for race $round")
                        }

                val raceData = groupedData.first()

                Race(
                    seasonYear = raceData.season,
                    round = raceData.round,
                    raceName = raceData.raceName,
                    circuit = raceData.circuit,
                    date = raceData.date,
                    winningDriver = winningPosition.driver,
                    winningConstructor = winningPosition.constructor,
                )
            }.also {
                logger.debug("Successfully retrieved ${it.size} races for season: $year from API")
            }
    }

    companion object {
        const val DRIVER_STANDINGS = "driverstandings"
        const val RESULTS_PATH = "results"
        const val LIMIT_PARAM = "limit"
        const val OFFSET_PARAM = "offset"
        const val LIMIT = 100
    }
}
