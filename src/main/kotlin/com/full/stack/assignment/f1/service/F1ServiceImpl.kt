package com.full.stack.assignment.f1.service

import com.full.stack.assignment.f1.data.cache.repository.CircuitCacheRepository
import com.full.stack.assignment.f1.data.cache.repository.ConstructorCacheRepository
import com.full.stack.assignment.f1.data.cache.repository.DriverCacheRepository
import com.full.stack.assignment.f1.data.cache.repository.RaceCacheRepository
import com.full.stack.assignment.f1.data.cache.repository.SeasonCacheRepository
import com.full.stack.assignment.f1.data.remote.RemoteApiRepository
import com.full.stack.assignment.f1.mapper.DriverMapper
import com.full.stack.assignment.f1.mapper.RaceMapper
import com.full.stack.assignment.f1.mapper.SeasonMapper
import com.full.stack.assignment.f1.model.Race
import com.full.stack.assignment.f1.model.Season
import jakarta.transaction.Transactional
import org.springframework.stereotype.Service

@Service
class F1ServiceImpl(
    private val remoteApiRepository: RemoteApiRepository,
    private val driverCacheRepository: DriverCacheRepository,
    private val seasonCacheRepository: SeasonCacheRepository,
    private val raceCacheRepository: RaceCacheRepository,
    private val constructorCacheRepository: ConstructorCacheRepository,
    private val circuitCacheRepository: CircuitCacheRepository,
    private val driverMapper: DriverMapper,
    private val seasonMapper: SeasonMapper,
    private val raceMapper: RaceMapper,
): F1Service {
    @Transactional
    override fun getSeasons(
        from: Int,
        to: Int
    ): List<Season> {
        val cachedSeasons = seasonCacheRepository.findByYearBetweenOrderByYearAsc(from, to)

        if (cachedSeasons.size == (to - from + 1)) {
            return cachedSeasons.map { seasonMapper.toDomain(it) }
        }

        val cachedYears = cachedSeasons.map { it.year }.toSet()
        val missingYears = (from..to).filter { it !in cachedYears }

        val newSeasons = missingYears.map { year -> getAndCacheSeason(year) }

        return (cachedSeasons.map { seasonMapper.toDomain(it) } + newSeasons).sortedBy { it.year }
    }

    @Transactional
    override fun getSeasonRaces(season: Int): List<Race> {
        if (!seasonCacheRepository.existsById(season)) {
            getAndCacheSeason(season)
        }

        val cachedRaces = raceCacheRepository.findBySeasonYear(season)
        if (cachedRaces.isNotEmpty()) {
            return cachedRaces.map { raceMapper.toDomain(it) }
        }

        val races = remoteApiRepository.getSeasonRaces(season)

        for (race in races) {
            val raceEntity = raceMapper.toEntity(race)
            circuitCacheRepository.save(raceEntity.circuit)
            constructorCacheRepository.save(raceEntity.winningConstructor)
            driverCacheRepository.save(raceEntity.winningDriver)
            raceCacheRepository.save(raceEntity)
        }

        return races
    }

    private fun getAndCacheSeason(year: Int): Season{
        val season = remoteApiRepository.getSeason(year)
        driverCacheRepository.save(driverMapper.toEntity(season.champion))
        seasonCacheRepository.save(seasonMapper.toEntity(season))
        return season
    }


}