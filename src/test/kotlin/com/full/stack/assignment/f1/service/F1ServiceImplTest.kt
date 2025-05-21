package com.full.stack.assignment.f1.service

import com.full.stack.assignment.f1.data.cache.entity.DriverEntity
import com.full.stack.assignment.f1.data.cache.entity.SeasonEntity
import com.full.stack.assignment.f1.data.cache.repository.CircuitCacheRepository
import com.full.stack.assignment.f1.data.cache.repository.ConstructorCacheRepository
import com.full.stack.assignment.f1.data.cache.repository.DriverCacheRepository
import com.full.stack.assignment.f1.data.cache.repository.RaceCacheRepository
import com.full.stack.assignment.f1.data.cache.repository.SeasonCacheRepository
import com.full.stack.assignment.f1.data.remote.RemoteApiRepository
import com.full.stack.assignment.f1.mapper.DriverMapper
import com.full.stack.assignment.f1.mapper.RaceMapper
import com.full.stack.assignment.f1.mapper.SeasonMapper
import com.full.stack.assignment.f1.model.Driver
import com.full.stack.assignment.f1.model.Season
import io.mockk.*
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.Assertions.*

private const val DUMMY_DRIVER_ID = "hamilton"

class F1ServiceImplTest {

    private lateinit var remoteApiRepository: RemoteApiRepository
    private lateinit var driverCacheRepository: DriverCacheRepository
    private lateinit var seasonCacheRepository: SeasonCacheRepository
    private lateinit var raceCacheRepository: RaceCacheRepository
    private lateinit var constructorCacheRepository: ConstructorCacheRepository
    private lateinit var circuitCacheRepository: CircuitCacheRepository
    private lateinit var driverMapper: DriverMapper
    private lateinit var seasonMapper: SeasonMapper
    private lateinit var raceMapper: RaceMapper
    private lateinit var f1Service: F1ServiceImpl

    @BeforeEach
    fun setUp() {
        remoteApiRepository = mockk()
        driverCacheRepository = mockk(relaxed = true)
        seasonCacheRepository = mockk(relaxed = true)
        raceCacheRepository = mockk(relaxed = true)
        constructorCacheRepository = mockk(relaxed = true)
        circuitCacheRepository = mockk(relaxed = true)
        driverMapper = mockk()
        seasonMapper = mockk()
        raceMapper = mockk()

        f1Service = F1ServiceImpl(
            remoteApiRepository,
            driverCacheRepository,
            seasonCacheRepository,
            raceCacheRepository,
            constructorCacheRepository,
            circuitCacheRepository,
            driverMapper,
            seasonMapper,
            raceMapper,
        )
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

    private fun createDriver(
        driverId: String = DUMMY_DRIVER_ID,
    ): Driver {
        return Driver(
            id = driverId,
            code = driverId.uppercase().take(3),
            firstName = "First",
            lastName = "Last",
            dateOfBirth = "1985-01-01",
            nationality = "British"
        )
    }

    private fun createDriverEntity(
        driverId: String = DUMMY_DRIVER_ID,
    ): DriverEntity {
        return DriverEntity(
            id = driverId,
            code = driverId.uppercase().take(3),
            firstName = "First",
            lastName = "Last",
            dateOfBirth = "1985-01-01",
            nationality = "British"
        )
    }

    private fun createSeason(
        year: Int,
        champion: Driver = createDriver(DUMMY_DRIVER_ID)
    ): Season {
        return Season(
            year = year,
            champion = champion
        )
    }

    private fun createSeasonEntity(
        year: Int,
        champion: DriverEntity = createDriverEntity(DUMMY_DRIVER_ID)
    ): SeasonEntity {
        return SeasonEntity(
            year = year,
            champion = champion
        )
    }
}