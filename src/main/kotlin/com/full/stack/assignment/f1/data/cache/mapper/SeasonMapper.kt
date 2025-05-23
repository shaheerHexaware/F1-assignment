package com.full.stack.assignment.f1.data.cache.mapper

import com.full.stack.assignment.f1.data.cache.entity.SeasonEntity
import com.full.stack.assignment.f1.model.Season
import org.springframework.stereotype.Component

@Component
class SeasonMapper(
    private val driverMapper: DriverMapper,
) : Mapper<Season, SeasonEntity> {
    override fun toDomain(entity: SeasonEntity): Season {
        return Season(
            year = entity.year,
            champion = driverMapper.toDomain(entity.champion),
        )
    }

    override fun toEntity(domain: Season): SeasonEntity {
        return SeasonEntity(
            year = domain.year,
            champion = driverMapper.toEntity(domain.champion),
        )
    }
}
