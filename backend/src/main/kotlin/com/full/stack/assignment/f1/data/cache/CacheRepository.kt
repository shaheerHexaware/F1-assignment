package com.full.stack.assignment.f1.data.cache

import com.full.stack.assignment.f1.data.cache.mapper.RaceMapper
import com.full.stack.assignment.f1.data.cache.mapper.SeasonMapper
import com.full.stack.assignment.f1.data.cache.repository.CircuitCacheRepository
import com.full.stack.assignment.f1.data.cache.repository.ConstructorCacheRepository
import com.full.stack.assignment.f1.data.cache.repository.DriverCacheRepository
import com.full.stack.assignment.f1.data.cache.repository.RaceCacheRepository
import com.full.stack.assignment.f1.data.cache.repository.SeasonCacheRepository
import com.full.stack.assignment.f1.model.Race
import com.full.stack.assignment.f1.model.Season
import jakarta.transaction.Transactional
import org.slf4j.LoggerFactory
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
    private val logger = LoggerFactory.getLogger(javaClass)

    fun getSeasons(
        from: Int,
        to: Int,
    ): List<Season> {
        return seasonCacheRepository
            .findByYearBetweenOrderByYearAsc(from, to)
            .map { seasonMapper.toDomain(it) }
    }

    fun hasSeason(year: Int): Boolean {
        return seasonCacheRepository.existsById(year)
    }

    @Transactional
    fun saveSeason(season: Season) {
        logger.info("Saving season data for year: ${season.year} to cache")
        val seasonEntity = seasonMapper.toEntity(season)
        driverCacheRepository.save(seasonEntity.champion)
        seasonCacheRepository.save(seasonEntity)
        logger.info("Successfully saved season data for year: ${season.year} to cache")
    }

    fun getRaces(season: Int): List<Race> {
        return raceCacheRepository.findBySeasonYearOrderByRoundAsc(season)
            .map { raceMapper.toDomain(it) }
    }

    @Transactional
    fun saveRace(race: Race) {
        logger.info("Saving race data for round: ${race.round} to cache")
        val raceEntity = raceMapper.toEntity(race)
        circuitCacheRepository.save(raceEntity.circuit)
        constructorCacheRepository.save(raceEntity.winningConstructor)
        driverCacheRepository.save(raceEntity.winningDriver)
        raceCacheRepository.save(raceEntity)
        logger.info("Successfully saved race data for round: ${race.round} to cache")
    }
}
