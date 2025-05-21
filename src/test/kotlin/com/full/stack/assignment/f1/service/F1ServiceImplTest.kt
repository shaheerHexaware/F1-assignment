package com.full.stack.assignment.f1.service

import com.full.stack.assignment.f1.DUMMY_SEASON
import com.full.stack.assignment.f1.Dummies.createDriver
import com.full.stack.assignment.f1.Dummies.createDriverEntity
import com.full.stack.assignment.f1.Dummies.createRace
import com.full.stack.assignment.f1.Dummies.createRaceEntity
import com.full.stack.assignment.f1.Dummies.createSeason
import com.full.stack.assignment.f1.Dummies.createSeasonEntity
import com.full.stack.assignment.f1.data.cache.entity.*
import com.full.stack.assignment.f1.data.cache.repository.*
import com.full.stack.assignment.f1.data.remote.RemoteApiRepository
import com.full.stack.assignment.f1.mapper.DriverMapper
import com.full.stack.assignment.f1.mapper.RaceMapper
import com.full.stack.assignment.f1.mapper.SeasonMapper
import com.full.stack.assignment.f1.model.Race
import io.mockk.*
import io.mockk.impl.annotations.MockK
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test

class F1ServiceImplTest {

    @MockK
    private lateinit var remoteApiRepository: RemoteApiRepository

    @MockK
    private lateinit var driverCacheRepository: DriverCacheRepository

    @MockK
    private lateinit var seasonCacheRepository: SeasonCacheRepository

    @MockK
    private lateinit var raceCacheRepository: RaceCacheRepository

    @MockK
    private lateinit var constructorCacheRepository: ConstructorCacheRepository

    @MockK
    private lateinit var circuitCacheRepository: CircuitCacheRepository

    @MockK
    private lateinit var driverMapper: DriverMapper

    @MockK
    private lateinit var seasonMapper: SeasonMapper

    @MockK
    private lateinit var raceMapper: RaceMapper

    private lateinit var f1Service: F1ServiceImpl

    @BeforeEach
    fun setUp() {
        MockKAnnotations.init(this)
        f1Service = F1ServiceImpl(
            remoteApiRepository,
            driverCacheRepository,
            seasonCacheRepository,
            raceCacheRepository,
            constructorCacheRepository,
            circuitCacheRepository,
            driverMapper,
            seasonMapper,
            raceMapper
        )

        every { circuitCacheRepository.save(any()) } returns mockk()
        every { constructorCacheRepository.save(any()) } returns mockk()
        every { driverCacheRepository.save(any()) } returns mockk()
        every { raceCacheRepository.save(any()) } returns mockk()
        every { seasonCacheRepository.save(any()) } returns mockk()
    }

    @Test
    fun `getSeasons should return cached seasons when all years are cached`() {
        val from = 2020
        val to = 2022
        val cachedSeasons = listOf(
            createSeasonEntity(2020),
            createSeasonEntity(2021),
            createSeasonEntity(2022)
        )
        val domainSeasons = listOf(
            createSeason(2020),
            createSeason(2021),
            createSeason(2022)
        )

        every { seasonCacheRepository.findByYearBetweenOrderByYearAsc(from, to) } returns cachedSeasons

        cachedSeasons.forEachIndexed { index, seasonEntity ->
            every { seasonMapper.toDomain(seasonEntity) } returns domainSeasons[index]
        }

        val result = f1Service.getSeasons(from, to)

        assertEquals(domainSeasons, result)
        verify(exactly = 0) { remoteApiRepository.getSeason(any()) }
        verify(exactly = 0) { driverCacheRepository.save(any()) }
        verify(exactly = 0) { seasonCacheRepository.save(any()) }
    }

    @Test
    fun `getSeasons should fetch missing years from API when some years are not cached`() {
        val from = 2020
        val to = 2022
        val cachedSeasons = listOf(
            createSeasonEntity(2020),
            createSeasonEntity(2022)
        )
        val domainCachedSeasons = listOf(
            createSeason(2020),
            createSeason(2022)
        )

        val missingYear = 2021
        val newDriverId = "verstappen"
        val newDriver = createDriver(newDriverId)
        val newSeason = createSeason(
            year = missingYear,
            champion = newDriver)
        val newDriverEntity = createDriverEntity(newDriverId)
        val newSeasonEntity = createSeasonEntity(
            year = missingYear,
            champion = newDriverEntity
        )

        every { seasonCacheRepository.findByYearBetweenOrderByYearAsc(from, to) } returns cachedSeasons
        every { remoteApiRepository.getSeason(missingYear) } returns newSeason
        every { driverMapper.toEntity(newSeason.champion) } returns newDriverEntity
        every { seasonMapper.toEntity(newSeason) } returns newSeasonEntity
        every { seasonCacheRepository.save(newSeasonEntity) } returns newSeasonEntity
        every { driverCacheRepository.save(newDriverEntity) } returns newDriverEntity

        cachedSeasons.forEachIndexed { index, seasonEntity ->
            every { seasonMapper.toDomain(seasonEntity) } returns domainCachedSeasons[index]
        }

        val result = f1Service.getSeasons(from, to)

        assertEquals(domainCachedSeasons[0], result[0])
        assertEquals(newSeason, result[1])
        assertEquals(domainCachedSeasons[1], result[2])
        verify(exactly = 1) { remoteApiRepository.getSeason(missingYear) }
        verify(exactly = 1) { driverCacheRepository.save(newDriverEntity) }
        verify(exactly = 1) { seasonCacheRepository.save(newSeasonEntity) }
    }

    @Test
    fun `getSeasons should fetch all years from API when none are cached`() {
        val from = 2020
        val to = 2021
        val emptyList = emptyList<SeasonEntity>()

        every { seasonCacheRepository.findByYearBetweenOrderByYearAsc(from, to) } returns emptyList

        val driverId2020 = "verstappen"
        val driverId2021 = "hamilton"

        val driver2020 = createDriver(driverId2020)
        val driver2021 = createDriver(driverId2021)

        val season2020 = createSeason(2020, champion = driver2020)
        val season2021 = createSeason(2021, champion = driver2021)

        val driverEntity2020 = createDriverEntity(driverId2020)
        val driverEntity2021 = createDriverEntity(driverId2021)

        val seasonEntity2020 = createSeasonEntity(2020, champion = driverEntity2020)
        val seasonEntity2021 = createSeasonEntity(2021, champion = driverEntity2021)

        every { remoteApiRepository.getSeason(2020) } returns season2020
        every { remoteApiRepository.getSeason(2021) } returns season2021

        every { driverMapper.toEntity(season2020.champion) } returns driverEntity2020
        every { driverMapper.toEntity(season2021.champion) } returns driverEntity2021

        every { seasonMapper.toEntity(season2020) } returns seasonEntity2020
        every { seasonMapper.toEntity(season2021) } returns seasonEntity2021

        every { driverCacheRepository.save(driverEntity2020) } returns driverEntity2020
        every { driverCacheRepository.save(driverEntity2021) } returns driverEntity2021

        every { seasonCacheRepository.save(seasonEntity2020) } returns seasonEntity2020
        every { seasonCacheRepository.save(seasonEntity2021) } returns seasonEntity2021

        val result = f1Service.getSeasons(from, to)

        assertEquals(season2020, result[0])
        assertEquals(season2021, result[1])
        verify(exactly = 1) { remoteApiRepository.getSeason(2020) }
        verify(exactly = 1) { remoteApiRepository.getSeason(2021) }
        verify(exactly = 1) { driverCacheRepository.save(driverEntity2020) }
        verify(exactly = 1) { driverCacheRepository.save(driverEntity2021) }
        verify(exactly = 1) { seasonCacheRepository.save(seasonEntity2020) }
        verify(exactly = 1) { seasonCacheRepository.save(seasonEntity2021) }
    }

    @Test
    fun `getSeasonRaces returns cached races when available`() {
        val raceEntity1 = createRaceEntity(seasonYear = DUMMY_SEASON, round = 1)
        val raceEntity2 = createRaceEntity(seasonYear = DUMMY_SEASON, round = 2)
        val cachedRaces = listOf(raceEntity1, raceEntity2)
        val domainRace1 = createRace(DUMMY_SEASON, 1)
        val domainRace2 = createRace(DUMMY_SEASON, 2)
        val expectedRaces = listOf(domainRace1, domainRace2)

        every { seasonCacheRepository.existsById(DUMMY_SEASON) } returns true
        every { raceCacheRepository.findBySeasonYear(DUMMY_SEASON) } returns cachedRaces
        every { raceMapper.toDomain(raceEntity1) } returns domainRace1
        every { raceMapper.toDomain(raceEntity2) } returns domainRace2

        val result = f1Service.getSeasonRaces(DUMMY_SEASON)

        assertEquals(expectedRaces, result)
        verify(exactly = 0) { remoteApiRepository.getSeasonRaces(DUMMY_SEASON) }
        verify(exactly = 1) { raceCacheRepository.findBySeasonYear(DUMMY_SEASON) }
        verify(exactly = 1) { raceMapper.toDomain(raceEntity1) }
        verify(exactly = 1) { raceMapper.toDomain(raceEntity2) }
    }

    @Test
    fun `getSeasonRaces fetches and caches races when season exists but no cached races`() {
        val remoteRace1 = createRace(DUMMY_SEASON, 1)
        val remoteRace2 = createRace(DUMMY_SEASON, 2)
        val remoteRaces = listOf(remoteRace1, remoteRace2)
        val raceEntity1 = createRaceEntity(seasonYear = DUMMY_SEASON, round = 1)
        val raceEntity2 = createRaceEntity(seasonYear = DUMMY_SEASON, round = 2)

        every { seasonCacheRepository.existsById(DUMMY_SEASON) } returns true
        every { raceCacheRepository.findBySeasonYear(DUMMY_SEASON) } returns emptyList()
        every { remoteApiRepository.getSeasonRaces(DUMMY_SEASON) } returns remoteRaces
        every { raceMapper.toEntity(remoteRace1) } returns raceEntity1
        every { raceMapper.toEntity(remoteRace2) } returns raceEntity2

        val result = f1Service.getSeasonRaces(DUMMY_SEASON)

        assertEquals(remoteRaces, result)
        verify(exactly = 1) { remoteApiRepository.getSeasonRaces(DUMMY_SEASON) }
        verify(exactly = 1) { raceCacheRepository.findBySeasonYear(DUMMY_SEASON) }
        verify(exactly = 1) { raceMapper.toEntity(remoteRace1) }
        verify(exactly = 1) { raceMapper.toEntity(remoteRace2) }
        verify(exactly = 2) { raceCacheRepository.save(any()) }
        verify(exactly = 2) { circuitCacheRepository.save(any()) }
        verify(exactly = 2) { constructorCacheRepository.save(any()) }
        verify(exactly = 2) { driverCacheRepository.save(any()) }
    }

    @Test
    fun `getSeasonRaces fetches and caches season when season doesn't exist`() {
        val remoteSeason = createSeason(DUMMY_SEASON)
        val seasonEntity = createSeasonEntity(DUMMY_SEASON)
        val championEntity = createDriverEntity("champ")
        val remoteRace1 = createRace(DUMMY_SEASON, 1)
        val remoteRace2 = createRace(DUMMY_SEASON, 2)
        val remoteRaces = listOf(remoteRace1, remoteRace2)
        val raceEntity1 = createRaceEntity(
            seasonYear = DUMMY_SEASON, round = 1,
            driverEntity = createDriverEntity("driver1")
        )
        val raceEntity2 = createRaceEntity(
            seasonYear = DUMMY_SEASON, round = 2,
            driverEntity = createDriverEntity("driver2")
        )

        every { seasonCacheRepository.existsById(DUMMY_SEASON) } returns false
        every { remoteApiRepository.getSeason(DUMMY_SEASON) } returns remoteSeason
        every { driverMapper.toEntity(remoteSeason.champion) } returns championEntity
        every { seasonMapper.toEntity(remoteSeason) } returns seasonEntity
        every { raceCacheRepository.findBySeasonYear(DUMMY_SEASON) } returns emptyList()
        every { remoteApiRepository.getSeasonRaces(DUMMY_SEASON) } returns remoteRaces
        every { raceMapper.toEntity(remoteRace1) } returns raceEntity1
        every { raceMapper.toEntity(remoteRace2) } returns raceEntity2

        val result = f1Service.getSeasonRaces(DUMMY_SEASON)

        assertEquals(remoteRaces, result)
        verify(exactly = 1) { remoteApiRepository.getSeason(DUMMY_SEASON) }
        verify(exactly = 1) { seasonCacheRepository.save(seasonEntity) }
        verify(exactly = 1) { driverCacheRepository.save(championEntity) }
        verify(exactly = 1) { remoteApiRepository.getSeasonRaces(DUMMY_SEASON) }
        verify(exactly = 2) { raceCacheRepository.save(any()) }
        verify(exactly = 2) { circuitCacheRepository.save(any()) }
        verify(exactly = 2) { constructorCacheRepository.save(any()) }
        verify(exactly = 1) { driverCacheRepository.save(raceEntity1.winningDriver) }
        verify(exactly = 1) { driverCacheRepository.save(raceEntity2.winningDriver) }
    }

    @Test
    fun `getSeasonRaces handles empty races list from remote API`() {
        every { seasonCacheRepository.existsById(DUMMY_SEASON) } returns true
        every { raceCacheRepository.findBySeasonYear(DUMMY_SEASON) } returns emptyList()
        every { remoteApiRepository.getSeasonRaces(DUMMY_SEASON) } returns emptyList()

        val result = f1Service.getSeasonRaces(DUMMY_SEASON)

        assertEquals(emptyList<Race>(), result)
        verify(exactly = 1) { remoteApiRepository.getSeasonRaces(DUMMY_SEASON) }
        verify(exactly = 1) { raceCacheRepository.findBySeasonYear(DUMMY_SEASON) }
        verify(exactly = 0) { raceCacheRepository.save(any()) }
        verify(exactly = 0) { circuitCacheRepository.save(any()) }
        verify(exactly = 0) { constructorCacheRepository.save(any()) }
        verify(exactly = 0) { driverCacheRepository.save(any()) }
    }
}
