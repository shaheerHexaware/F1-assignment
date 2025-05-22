package com.full.stack.assignment.f1.data.cache

import com.full.stack.assignment.f1.data.cache.repository.CircuitCacheRepository
import com.full.stack.assignment.f1.data.cache.repository.ConstructorCacheRepository
import com.full.stack.assignment.f1.data.cache.repository.DriverCacheRepository
import com.full.stack.assignment.f1.data.cache.repository.RaceCacheRepository
import com.full.stack.assignment.f1.data.cache.repository.SeasonCacheRepository
import com.full.stack.assignment.f1.mapper.RaceMapper
import com.full.stack.assignment.f1.mapper.SeasonMapper
import com.full.stack.assignment.f1.model.Race
import com.full.stack.assignment.f1.model.Season
import org.springframework.stereotype.Repository

@Repository
class CacheRepository(
    private val driverCacheRepository: DriverCacheRepository,
    private val seasonCacheRepository: SeasonCacheRepository,
    private val raceCacheRepository: RaceCacheRepository,
    private val constructorCacheRepository: ConstructorCacheRepository,
    private val circuitCacheRepository: CircuitCacheRepository,
    private val seasonMapper: SeasonMapper,
    private val raceMapper: RaceMapper,
) {
    fun getSeasons(from: Int, to: Int): List<Season> {
        return seasonCacheRepository
            .findByYearBetweenOrderByYearAsc(from, to)
            .map { seasonMapper.toDomain(it) }
    }

    fun hasSeason(year: Int): Boolean {
        return seasonCacheRepository.existsById(year)
    }

    fun saveSeason(season: Season) {
        val seasonEntity = seasonMapper.toEntity(season)
        driverCacheRepository.save(seasonEntity.champion)
        seasonCacheRepository.save(seasonEntity)
    }

    fun getRaces(season: Int): List<Race> {
        return raceCacheRepository.findBySeasonYearOrderByRoundAsc(season)
            .map { raceMapper.toDomain(it) }
    }

    fun saveRace(race: Race) {
        val raceEntity = raceMapper.toEntity(race)
        circuitCacheRepository.save(raceEntity.circuit)
        constructorCacheRepository.save(raceEntity.winningConstructor)
        driverCacheRepository.save(raceEntity.winningDriver)
        raceCacheRepository.save(raceEntity)
    }
}