package com.full.stack.assignment.f1.service

import com.full.stack.assignment.f1.data.cache.CacheRepository
import com.full.stack.assignment.f1.data.remote.RemoteRepository
import com.full.stack.assignment.f1.model.Race
import com.full.stack.assignment.f1.model.Season
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service

@Service
class F1ServiceImpl(
    private val remoteRepository: RemoteRepository,
    private val cacheRepository: CacheRepository,
) : F1Service {

    private val logger = LoggerFactory.getLogger(javaClass)

    override fun getSeasons(
        from: Int,
        to: Int,
    ): List<Season> {
        logger.info("Fetching data for $from-$to seasons.")
        val cachedSeasons = cacheRepository.getSeasons(from, to)

        if (cachedSeasons.size == (to - from + 1)) {
            return cachedSeasons
        }

        logger.info("Partial cache hit: ${cachedSeasons.size}/${(to - from + 1)} seasons found. Fetching missing data from remote API.")

        val cachedYears = cachedSeasons.map { it.year }.toSet()
        val missingYears = (from..to).filter { it !in cachedYears }

        val newSeasons = missingYears.map { year -> getAndCacheSeason(year) }

        logger.info("Successfully retrieved and cached data for ${missingYears.size} seasons.")
        return (cachedSeasons + newSeasons).sortedBy { it.year }
    }

    override fun getSeasonRaces(season: Int): List<Race> {
        logger.info("Fetching races for season $season.")

        if (!cacheRepository.hasSeason(season)) {
            logger.info("Cache miss: season $season not found in cache. Fetching Season from remote API first.")
            getAndCacheSeason(season)
        }

        val cachedRaces = cacheRepository.getRaces(season)
        if (cachedRaces.isNotEmpty()) {
            return cachedRaces
        }

        logger.info("Cache miss: season $season has no races in cache. Fetching races from remote API.")

        val races = remoteRepository.getSeasonRaces(season)

        for (race in races) {
            cacheRepository.saveRace(race)
        }

        logger.info("Successfully retrieved and cached data for ${races.size} races in season $season.")
        return races
    }

    private fun getAndCacheSeason(year: Int): Season {
        val season = remoteRepository.getSeason(year)
        cacheRepository.saveSeason(season)
        return season
    }
}
