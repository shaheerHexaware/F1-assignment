package com.full.stack.assignment.f1.data.remote

import com.full.stack.assignment.f1.data.remote.RemoteApiRepository.Companion.DRIVER_STANDINGS
import com.full.stack.assignment.f1.data.remote.model.DriverStandingDTO
import com.full.stack.assignment.f1.data.remote.model.DriverStandingDataDTO
import com.full.stack.assignment.f1.data.remote.model.DriverStandingResponseDTO
import com.full.stack.assignment.f1.data.remote.model.SeasonRoundDTO
import com.full.stack.assignment.f1.data.remote.model.StandingsTableDTO
import com.full.stack.assignment.f1.model.Driver
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test
import org.mockito.Mockito.mock
import org.mockito.Mockito.`when`
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.client.RestClientException
import org.springframework.web.client.RestTemplate
import java.util.Random

const val DUMMY_BASE_URL = "https://races.com/f1/api"

class RemoteApiRepositoryTest {

    private val restTemplate: RestTemplate = mock(RestTemplate::class.java)
    private val repository = RemoteApiRepository(DUMMY_BASE_URL, restTemplate)

    @Test
    fun `getSeason should return Season when API call is successful`() {
        val year = 2023
        val driver = getDummyDriver()
        val responseDTO = getDummyApiResponse(
            driverStandingDTO = getDummyDriverPosition(1, driver),
        )

        val url = "${DUMMY_BASE_URL}/$year/$DRIVER_STANDINGS/"
        `when`(restTemplate.getForEntity(url, DriverStandingResponseDTO::class.java))
            .thenReturn(ResponseEntity(responseDTO, HttpStatus.OK))

        val result = repository.getSeason(year)

        assertEquals(year, result.year)
        assertEquals(driver, result.champion)
    }

    @Test
    fun `getSeason should throw RestClientException when API call fails`() {
        val year = 2023
        val url = "${DUMMY_BASE_URL}/$year/$DRIVER_STANDINGS/"

        `when`(restTemplate.getForEntity(url, DriverStandingResponseDTO::class.java))
            .thenReturn(ResponseEntity(null, HttpStatus.INTERNAL_SERVER_ERROR))

        val exception = assertThrows(RestClientException::class.java) {
            repository.getSeason(year)
        }

        assertEquals("Error retrieving season $year", exception.message)
    }

    @Test
    fun `getSeason should throw IllegalStateException when no winning driver is found`() {
        val year = 2023
        val responseDTO = getDummyApiResponse(
            driverStandingDTO = getDummyDriverPosition(2),
        )

        val url = "${DUMMY_BASE_URL}/$year/$DRIVER_STANDINGS/"
        `when`(restTemplate.getForEntity(url, DriverStandingResponseDTO::class.java))
            .thenReturn(ResponseEntity(responseDTO, HttpStatus.OK))

        val exception = assertThrows(IllegalStateException::class.java) {
            repository.getSeason(year)
        }

        assertEquals("Unable to find winning driver for year $year", exception.message)
    }

    private fun getDummyApiResponse(
        driverStandingDTO: DriverStandingDTO = getDummyDriverPosition()
    ): DriverStandingResponseDTO {
        val seasonRoundDTO = SeasonRoundDTO(
            round = 1,
            driverStandings = listOf(driverStandingDTO)
        )
        val standingsTableDTO = StandingsTableDTO(
            standingsList = listOf(seasonRoundDTO)
        )
        val driverStandingDataDTO = DriverStandingDataDTO(
            standingsTable = standingsTableDTO
        )
        return DriverStandingResponseDTO(
            driverStandingsData = driverStandingDataDTO
        )
    }

    private fun getDummyDriverPosition(
        position: Int = 1,
        driver: Driver = getDummyDriver(),
    ): DriverStandingDTO {
        return DriverStandingDTO(
            position = position,
            points = Random().nextDouble(0.0, 400.0),
            wins = Random().nextInt(7, 12),
            driver = driver
        )
    }

    private fun getDummyDriver(): Driver {
        return Driver(
            id = "hamilton",
            code = "HAM",
            firstName = "Lewis",
            lastName = "Hamilton",
            dateOfBirth = "1985-01-07",
            nationality = "British"
        )
    }


}