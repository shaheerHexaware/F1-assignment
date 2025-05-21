package com.full.stack.assignment.f1.data.cache.repository

import com.full.stack.assignment.f1.data.cache.entity.SeasonEntity
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface SeasonCacheRepository : JpaRepository<SeasonEntity, Int> {
    fun findByYearBetweenOrderByYearAsc(startYear: Int, endYear: Int): List<SeasonEntity>
}