package com.full.stack.assignment.f1.data.cache

import com.full.stack.assignment.f1.Dummies.createRace
import com.full.stack.assignment.f1.Dummies.createRaceEntity
import com.full.stack.assignment.f1.Dummies.createSeason
import com.full.stack.assignment.f1.Dummies.createSeasonEntity
import com.full.stack.assignment.f1.data.cache.mapper.RaceMapper
import com.full.stack.assignment.f1.data.cache.mapper.SeasonMapper
import com.full.stack.assignment.f1.data.cache.repository.CircuitCacheRepository
import com.full.stack.assignment.f1.data.cache.repository.ConstructorCacheRepository
import com.full.stack.assignment.f1.data.cache.repository.DriverCacheRepository
import com.full.stack.assignment.f1.data.cache.repository.RaceCacheRepository
import com.full.stack.assignment.f1.data.cache.repository.SeasonCacheRepository
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.verify
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test

class CacheRepositoryTest {
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
    private lateinit var seasonMapper: SeasonMapper

    @MockK
    private lateinit var raceMapper: RaceMapper

    private lateinit var cacheRepository: CacheRepository

    @BeforeEach
    fun setup() {
        MockKAnnotations.init(this)
        cacheRepository =
            CacheRepository(
                driverCacheRepository,
                seasonCacheRepository,
                raceCacheRepository,
                constructorCacheRepository,
                circuitCacheRepository,
                seasonMapper,
                raceMapper,
            )
    }

    @Test
    fun `getSeasons returns mapped seasons when repository returns entities`() {
        val from = 2020
        val to = 2022
        val seasonEntities =
            listOf(
                createSeasonEntity(2020),
                createSeasonEntity(2021),
                createSeasonEntity(2022),
            )
        val expectedSeasons =
            listOf(
                createSeason(2020),
                createSeason(2021),
                createSeason(2022),
            )

        every {
            seasonCacheRepository.findByYearBetweenOrderByYearAsc(from, to)
        } returns seasonEntities

        seasonEntities.forEachIndexed { index, entity ->
            every { seasonMapper.toDomain(entity) } returns expectedSeasons[index]
        }

        val result = cacheRepository.getSeasons(from, to)

        assertEquals(expectedSeasons, result)
        verify(exactly = 1) { seasonCacheRepository.findByYearBetweenOrderByYearAsc(from, to) }
        verify(exactly = 3) { seasonMapper.toDomain(any()) }
    }

    @Test
    fun `hasSeason returns true when season exists`() {
        val year = 2023
        every { seasonCacheRepository.existsById(year) } returns true

        val result = cacheRepository.hasSeason(year)

        assertTrue(result)
        verify(exactly = 1) { seasonCacheRepository.existsById(year) }
    }

    @Test
    fun `hasSeason returns false when season does not exist`() {
        val year = 2023
        every { seasonCacheRepository.existsById(year) } returns false

        val result = cacheRepository.hasSeason(year)

        assertFalse(result)
        verify(exactly = 1) { seasonCacheRepository.existsById(year) }
    }

    @Test
    fun `saveSeason saves driver and season entity`() {
        val season = createSeason()
        val seasonEntity = createSeasonEntity()

        every { seasonMapper.toEntity(season) } returns seasonEntity
        every { driverCacheRepository.save(seasonEntity.champion) } returns seasonEntity.champion
        every { seasonCacheRepository.save(seasonEntity) } returns seasonEntity

        cacheRepository.saveSeason(season)

        verify(exactly = 1) { seasonMapper.toEntity(season) }
        verify(exactly = 1) { driverCacheRepository.save(seasonEntity.champion) }
        verify(exactly = 1) { seasonCacheRepository.save(seasonEntity) }
    }

    @Test
    fun `getRaces returns mapped races when repository returns entities`() {
        val year = 2023
        val raceEntities =
            listOf(
                createRaceEntity(round = 1),
                createRaceEntity(round = 2),
            )
        val expectedRaces =
            listOf(
                createRace(round = 1),
                createRace(round = 2),
            )

        every { raceCacheRepository.findBySeasonYearOrderByRoundAsc(year) } returns raceEntities

        raceEntities.forEachIndexed { index, entity ->
            every { raceMapper.toDomain(entity) } returns expectedRaces[index]
        }

        val result = cacheRepository.getRaces(year)

        assertEquals(expectedRaces, result)
        verify(exactly = 1) { raceCacheRepository.findBySeasonYearOrderByRoundAsc(year) }
        verify(exactly = 2) { raceMapper.toDomain(any()) }
    }

    @Test
    fun `saveRace saves circuit, constructor, driver and race entity`() {
        val race = createRace()
        val raceEntity = createRaceEntity()

        every { raceMapper.toEntity(race) } returns raceEntity
        every { circuitCacheRepository.save(raceEntity.circuit) } returns raceEntity.circuit
        every { constructorCacheRepository.save(raceEntity.winningConstructor) } returns raceEntity.winningConstructor
        every { driverCacheRepository.save(raceEntity.winningDriver) } returns raceEntity.winningDriver
        every { raceCacheRepository.save(raceEntity) } returns raceEntity

        cacheRepository.saveRace(race)

        verify(exactly = 1) { raceMapper.toEntity(race) }
        verify(exactly = 1) { circuitCacheRepository.save(raceEntity.circuit) }
        verify(exactly = 1) { constructorCacheRepository.save(raceEntity.winningConstructor) }
        verify(exactly = 1) { driverCacheRepository.save(raceEntity.winningDriver) }
        verify(exactly = 1) { raceCacheRepository.save(raceEntity) }
    }
}
