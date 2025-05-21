package com.full.stack.assignment.f1.data.remote

import com.full.stack.assignment.f1.data.remote.model.DriverStandingResponseDTO
import com.full.stack.assignment.f1.model.Season
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.beans.factory.annotation.Value
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Repository
import org.springframework.web.client.RestClientException
import org.springframework.web.client.RestTemplate
import org.springframework.web.client.getForEntity

@Repository
class RemoteApiRepository(
    @Value("\${api.base.url}") private val baseUrl: String,
    @Autowired private val restTemplate: RestTemplate,
) {
    fun getSeason(year: Int): Season {
        val url = "$baseUrl/$year/$DRIVER_STANDINGS/"
        val response: ResponseEntity<DriverStandingResponseDTO> = restTemplate.getForEntity(url)

        if (response.statusCode.isError) throw RestClientException("Error retrieving season $year")

        val winningDriver =
            response.body?.driverStandingsData?.standingsTable?.standingsList?.firstOrNull()?.driverStandings?.find { it.position == 1 }
                ?: throw IllegalStateException("Unable to find winning driver for year $year")
        return Season(
            year = year,
            champion = winningDriver.driver
        )
    }

    companion object{
        const val DRIVER_STANDINGS = "driverstandings"
    }
}