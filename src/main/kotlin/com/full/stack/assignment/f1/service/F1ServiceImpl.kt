package com.full.stack.assignment.f1.service

import com.full.stack.assignment.f1.data.cache.CacheRepository
import com.full.stack.assignment.f1.data.remote.RemoteRepository
import com.full.stack.assignment.f1.model.Race
import com.full.stack.assignment.f1.model.Season
import jakarta.transaction.Transactional
import org.springframework.stereotype.Service

@Service
class F1ServiceImpl(
    private val remoteRepository: RemoteRepository,
    private val cacheRepository: CacheRepository
): F1Service {

    @Transactional
    override fun getSeasons(
        from: Int,
        to: Int
    ): List<Season> {
        val cachedSeasons = cacheRepository.getSeasons(from, to)

        if (cachedSeasons.size == (to - from + 1)) {
            return cachedSeasons
        }

        val cachedYears = cachedSeasons.map { it.year }.toSet()
        val missingYears = (from..to).filter { it !in cachedYears }

        val newSeasons = missingYears.map { year -> getAndCacheSeason(year) }

        return (cachedSeasons + newSeasons).sortedBy { it.year }
    }

    @Transactional
    override fun getSeasonRaces(season: Int): List<Race> {
        if (!cacheRepository.hasSeason(season)) {
            getAndCacheSeason(season)
        }

        val cachedRaces = cacheRepository.getRaces(season)
        if (cachedRaces.isNotEmpty()) {
            return cachedRaces
        }

        val races = remoteRepository.getSeasonRaces(season)

        for (race in races) {
            cacheRepository.saveRace(race)
        }

        return races
    }

    private fun getAndCacheSeason(year: Int): Season{
        val season = remoteRepository.getSeason(year)
        cacheRepository.saveSeason(season)
        return season
    }


}