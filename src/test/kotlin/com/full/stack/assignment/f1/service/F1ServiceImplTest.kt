package com.full.stack.assignment.f1.service

import com.full.stack.assignment.f1.DUMMY_SEASON
import com.full.stack.assignment.f1.Dummies.createDriver
import com.full.stack.assignment.f1.Dummies.createRace
import com.full.stack.assignment.f1.Dummies.createSeason
import com.full.stack.assignment.f1.data.cache.CacheRepository
import com.full.stack.assignment.f1.data.remote.RemoteRepository
import com.full.stack.assignment.f1.model.Race
import com.full.stack.assignment.f1.model.Season
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.mockk
import io.mockk.verify
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test

class F1ServiceImplTest {

    @MockK
    private lateinit var remoteRepository: RemoteRepository

    @MockK
    private lateinit var cacheRepository: CacheRepository

    private lateinit var f1Service: F1ServiceImpl

    @BeforeEach
    fun setUp() {
        MockKAnnotations.init(this)
        f1Service = F1ServiceImpl(
            remoteRepository,
            cacheRepository
        )

        every { cacheRepository.saveRace(any()) } returns mockk()
        every { cacheRepository.saveSeason(any()) } returns mockk()
    }

    @Test
    fun `getSeasons should return cached seasons when all years are cached`() {
        val from = 2020
        val to = 2022
        val domainSeasons = listOf(
            createSeason(2020),
            createSeason(2021),
            createSeason(2022)
        )

        every { cacheRepository.getSeasons(from, to) } returns domainSeasons

        val result = f1Service.getSeasons(from, to)

        assertEquals(domainSeasons, result)
        verify(exactly = 0) { remoteRepository.getSeason(any()) }
        verify(exactly = 0) { cacheRepository.saveSeason(any()) }
    }

    @Test
    fun `getSeasons should fetch missing years from API when some years are not cached`() {
        val from = 2020
        val to = 2022
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

        every { cacheRepository.getSeasons(from, to) } returns domainCachedSeasons
        every { remoteRepository.getSeason(missingYear) } returns newSeason

        val result = f1Service.getSeasons(from, to)

        assertEquals(domainCachedSeasons[0], result[0])
        assertEquals(newSeason, result[1])
        assertEquals(domainCachedSeasons[1], result[2])
        verify(exactly = 1) { remoteRepository.getSeason(missingYear) }
        verify(exactly = 1) { cacheRepository.saveSeason(newSeason) }
    }

    @Test
    fun `getSeasons should fetch all years from API when none are cached`() {
        val from = 2020
        val to = 2021
        val emptyList = emptyList<Season>()

        every { cacheRepository.getSeasons(from, to) } returns emptyList

        val driverId2020 = "verstappen"
        val driverId2021 = "hamilton"

        val driver2020 = createDriver(driverId2020)
        val driver2021 = createDriver(driverId2021)

        val season2020 = createSeason(2020, champion = driver2020)
        val season2021 = createSeason(2021, champion = driver2021)

        every { remoteRepository.getSeason(2020) } returns season2020
        every { remoteRepository.getSeason(2021) } returns season2021

        val result = f1Service.getSeasons(from, to)

        assertEquals(season2020, result[0])
        assertEquals(season2021, result[1])
        verify(exactly = 1) { remoteRepository.getSeason(2020) }
        verify(exactly = 1) { remoteRepository.getSeason(2021) }
        verify(exactly = 1) { cacheRepository.saveSeason(season2020) }
        verify(exactly = 1) { cacheRepository.saveSeason(season2021) }
    }

    @Test
    fun `getSeasonRaces returns cached races when available`() {
        val domainRace1 = createRace(DUMMY_SEASON, 1)
        val domainRace2 = createRace(DUMMY_SEASON, 2)
        val expectedRaces = listOf(domainRace1, domainRace2)

        every { cacheRepository.hasSeason(DUMMY_SEASON) } returns true
        every { cacheRepository.getRaces(DUMMY_SEASON) } returns expectedRaces

        val result = f1Service.getSeasonRaces(DUMMY_SEASON)

        assertEquals(expectedRaces, result)
        verify(exactly = 0) { remoteRepository.getSeasonRaces(DUMMY_SEASON) }
        verify(exactly = 1) { cacheRepository.getRaces(DUMMY_SEASON) }
    }

    @Test
    fun `getSeasonRaces fetches and caches races when season exists but no cached races`() {
        val remoteRace1 = createRace(DUMMY_SEASON, 1)
        val remoteRace2 = createRace(DUMMY_SEASON, 2)
        val remoteRaces = listOf(remoteRace1, remoteRace2)

        every { cacheRepository.hasSeason(DUMMY_SEASON) } returns true
        every { cacheRepository.getRaces(DUMMY_SEASON) } returns emptyList()
        every { remoteRepository.getSeasonRaces(DUMMY_SEASON) } returns remoteRaces

        val result = f1Service.getSeasonRaces(DUMMY_SEASON)

        assertEquals(remoteRaces, result)
        verify(exactly = 1) { remoteRepository.getSeasonRaces(DUMMY_SEASON) }
        verify(exactly = 1) { cacheRepository.getRaces(DUMMY_SEASON) }
        verify(exactly = 2) { cacheRepository.saveRace(any()) }
    }

    @Test
    fun `getSeasonRaces fetches and caches season when season doesn't exist`() {
        val remoteSeason = createSeason(DUMMY_SEASON)
        val remoteRace1 = createRace(DUMMY_SEASON, 1)
        val remoteRace2 = createRace(DUMMY_SEASON, 2)
        val remoteRaces = listOf(remoteRace1, remoteRace2)

        every { cacheRepository.hasSeason(DUMMY_SEASON) } returns false
        every { remoteRepository.getSeason(DUMMY_SEASON) } returns remoteSeason
        every { cacheRepository.getRaces(DUMMY_SEASON) } returns emptyList()
        every { remoteRepository.getSeasonRaces(DUMMY_SEASON) } returns remoteRaces

        val result = f1Service.getSeasonRaces(DUMMY_SEASON)

        assertEquals(remoteRaces, result)
        verify(exactly = 1) { remoteRepository.getSeason(DUMMY_SEASON) }
        verify(exactly = 1) { cacheRepository.saveSeason(remoteSeason) }
        verify(exactly = 1) { remoteRepository.getSeasonRaces(DUMMY_SEASON) }
        verify(exactly = 2) { cacheRepository.saveRace(any()) }
    }

    @Test
    fun `getSeasonRaces handles empty races list from remote API`() {
        every { cacheRepository.hasSeason(DUMMY_SEASON) } returns true
        every { cacheRepository.getRaces(DUMMY_SEASON) } returns emptyList()
        every { remoteRepository.getSeasonRaces(DUMMY_SEASON) } returns emptyList()

        val result = f1Service.getSeasonRaces(DUMMY_SEASON)

        assertEquals(emptyList<Race>(), result)
        verify(exactly = 1) { remoteRepository.getSeasonRaces(DUMMY_SEASON) }
        verify(exactly = 1) { cacheRepository.getRaces(DUMMY_SEASON) }
        verify(exactly = 0) { cacheRepository.saveRace(any()) }
    }
}
