package com.full.stack.assignment.f1.data.cache.repository

import com.full.stack.assignment.f1.data.cache.entity.RaceEntity
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface RaceCacheRepository : JpaRepository<RaceEntity, Long> {
    fun findBySeasonYearOrderByRoundAsc(year: Int): List<RaceEntity>
}