package com.full.stack.assignment.f1.data.remote

import com.full.stack.assignment.f1.data.remote.RemoteApiRepository.Companion.DRIVER_STANDINGS
import com.full.stack.assignment.f1.data.remote.RemoteApiRepository.Companion.LIMIT
import com.full.stack.assignment.f1.data.remote.RemoteApiRepository.Companion.LIMIT_PARAM
import com.full.stack.assignment.f1.data.remote.RemoteApiRepository.Companion.OFFSET_PARAM
import com.full.stack.assignment.f1.data.remote.RemoteApiRepository.Companion.RESULTS_PATH
import com.full.stack.assignment.f1.data.remote.model.DriverPositionDTO
import com.full.stack.assignment.f1.data.remote.model.DriverStandingDTO
import com.full.stack.assignment.f1.data.remote.model.DriverStandingDataDTO
import com.full.stack.assignment.f1.data.remote.model.DriverStandingResponseDTO
import com.full.stack.assignment.f1.data.remote.model.RaceDTO
import com.full.stack.assignment.f1.data.remote.model.RaceTableDTO
import com.full.stack.assignment.f1.data.remote.model.SeasonRacesPagedDataDTO
import com.full.stack.assignment.f1.data.remote.model.SeasonRacesResponseDTO
import com.full.stack.assignment.f1.data.remote.model.SeasonRoundDTO
import com.full.stack.assignment.f1.data.remote.model.StandingsTableDTO
import com.full.stack.assignment.f1.model.Circuit
import com.full.stack.assignment.f1.model.CircuitLocation
import com.full.stack.assignment.f1.model.Constructor
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

private const val DUMMY_BASE_URL = "https://races.com/f1/api"
private const val DUMMY_DRIVER_ID = "hamilton"
private const val DUMMY_CONSTRUCTOR_ID = "redbull"
private const val DUMMY_CIRCUIT_ID = "bahrain"
private const val DUMMY_RACE_NAME = "Bahrain Grand Prix"
private const val DUMMY_SEASON = 2023

class RemoteApiRepositoryTest {

    private val restTemplate: RestTemplate = mock(RestTemplate::class.java)
    private val repository = RemoteApiRepository(DUMMY_BASE_URL, restTemplate)

    @Test
    fun `getSeason should return Season when API call is successful`() {
        val year = DUMMY_SEASON
        val driver = getDummyDriver()
        val responseDTO = getDummySeasonApiResponse(
            driverStandingDTO = getDummyDriverStanding(1, driver),
        )

        val url = "${DUMMY_BASE_URL}/$year/$DRIVER_STANDINGS"
        `when`(restTemplate.getForEntity(url, DriverStandingResponseDTO::class.java))
            .thenReturn(ResponseEntity(responseDTO, HttpStatus.OK))

        val result = repository.getSeason(year)

        assertEquals(year, result.year)
        assertEquals(driver, result.champion)
    }

    @Test
    fun `getSeason should throw RestClientException when API call fails`() {
        val year = DUMMY_SEASON
        val url = "${DUMMY_BASE_URL}/$year/$DRIVER_STANDINGS"

        `when`(restTemplate.getForEntity(url, DriverStandingResponseDTO::class.java))
            .thenReturn(ResponseEntity(null, HttpStatus.INTERNAL_SERVER_ERROR))

        val exception = assertThrows(RestClientException::class.java) {
            repository.getSeason(year)
        }

        assertEquals("Error retrieving season $year", exception.message)
    }

    @Test
    fun `getSeason should throw IllegalStateException when no winning driver is found`() {
        val year = DUMMY_SEASON
        val responseDTO = getDummySeasonApiResponse(
            driverStandingDTO = getDummyDriverStanding(2),
        )

        val url = "${DUMMY_BASE_URL}/$year/$DRIVER_STANDINGS"
        `when`(restTemplate.getForEntity(url, DriverStandingResponseDTO::class.java))
            .thenReturn(ResponseEntity(responseDTO, HttpStatus.OK))

        val exception = assertThrows(IllegalStateException::class.java) {
            repository.getSeason(year)
        }

        assertEquals("Unable to find winning driver for year $year", exception.message)
    }

    @Test
    fun `getSeasonRaces should return a list of Race objects when API call is successful`() {
        val year = DUMMY_SEASON
        val responseDTO = getDummyRacesResponse()
        val url = "${DUMMY_BASE_URL}/$year/$RESULTS_PATH?$LIMIT_PARAM=$LIMIT&$OFFSET_PARAM=0"
        println("url: $url")

        `when`(restTemplate.getForEntity(url, SeasonRacesResponseDTO::class.java))
            .thenReturn(ResponseEntity(responseDTO, HttpStatus.OK))

        val result = repository.getSeasonRaces(year)

        assertEquals(1, result.size)
        val race = result[0]
        assertEquals(DUMMY_RACE_NAME, race.raceName)
        assertEquals(DUMMY_RACE_NAME, race.raceName)
        assertEquals(getDummyCircuit(), race.circuit)
        assertEquals(getDummyDriver(), race.winningDriver)
        assertEquals(getDummyConstructor(), race.winningConstructor)
    }

    @Test
    fun `getSeasonRaces should throw RestClientException when API call fails`() {
        val year = DUMMY_SEASON
        val url = "${DUMMY_BASE_URL}/$year/$RESULTS_PATH?$LIMIT_PARAM=$LIMIT&$OFFSET_PARAM=0"
        println("url: $url")

        `when`(restTemplate.getForEntity(url, SeasonRacesResponseDTO::class.java))
            .thenReturn(ResponseEntity(null, HttpStatus.INTERNAL_SERVER_ERROR))

        val exception = assertThrows(RestClientException::class.java) {
            repository.getSeasonRaces(year)
        }

        assertEquals("Error retrieving races for season $year", exception.message)
    }

    @Test
    fun `getSeasonRaces should throw RestClientException when no winning driver is found`() {
        val year = DUMMY_SEASON
        val responseDTO = getDummyRacesResponse(
            races = listOf(getDummyRace(
                driverPositions = listOf(getDummyDriverPosition(2))
            ),)
        )
        val url = "${DUMMY_BASE_URL}/$year/$RESULTS_PATH?$LIMIT_PARAM=$LIMIT&$OFFSET_PARAM=0"
        println("url: $url")

        `when`(restTemplate.getForEntity(url, SeasonRacesResponseDTO::class.java))
            .thenReturn(ResponseEntity(responseDTO, HttpStatus.OK))

        val exception = assertThrows(RestClientException::class.java) {
            repository.getSeasonRaces(year)
        }

        assertEquals("Error retrieving winning driver for race 1", exception.message)
    }

    private fun getDummyRacesResponse(
        limit: Int = LIMIT,
        offset: Int = 0,
        total: Int = LIMIT,
        season: Int = DUMMY_SEASON,
        races: List<RaceDTO> = listOf(getDummyRace())
    ): SeasonRacesResponseDTO{
        return SeasonRacesResponseDTO(
            seasonRacesPagedData = SeasonRacesPagedDataDTO(
                limit = limit,
                offset = offset,
                total = total,
                raceTable = RaceTableDTO(
                    season = season,
                    races = races
                )
            )
        )
    }

    private fun getDummyRace(
        year: Int = DUMMY_SEASON,
        raceName: String = DUMMY_RACE_NAME,
        circuit: Circuit = getDummyCircuit(),
        driverPositions: List<DriverPositionDTO> = listOf(getDummyDriverPosition())
    ): RaceDTO {
        return RaceDTO(
            season = year,
            round = 1,
            raceName = raceName,
            circuit = circuit,
            date = "2023-03-05",
            results = driverPositions
        )
    }

    private fun getDummyDriverPosition(
        position: Int = 1,
        driver: Driver = getDummyDriver(),
        constructor: Constructor = getDummyConstructor(),
    ): DriverPositionDTO {
        return DriverPositionDTO(
            number = 33,
            position = position,
            points = 396.0,
            driver = driver,
            constructor = constructor,
            grid = 1,
            laps = 58,
            status = "Finished"
        )
    }

    private fun getDummySeasonApiResponse(
        driverStandingDTO: DriverStandingDTO = getDummyDriverStanding()
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

    private fun getDummyDriverStanding(
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

    private fun getDummyDriver(
        driverId: String = DUMMY_DRIVER_ID,
    ): Driver {
        return Driver(
            id = driverId,
            code = driverId.uppercase().take(3),
            firstName = "Lewis",
            lastName = "Hamilton",
            dateOfBirth = "1985-01-07",
            nationality = "British"
        )
    }

    private fun getDummyConstructor(
        constructorId: String = DUMMY_CONSTRUCTOR_ID,
    ): Constructor {
        return Constructor(
            id = constructorId,
            name = "Red Bull Racing",
            nationality = "Austrian"
        )
    }

    private fun getDummyCircuit(
        circuitId: String = DUMMY_CIRCUIT_ID,
    ): Circuit {
        return Circuit(
            id = circuitId,
            name = "Bahrain International Circuit",
            location = CircuitLocation(
                locality = "Sakhir",
                country = "Bahrain"
            )
        )
    }


}