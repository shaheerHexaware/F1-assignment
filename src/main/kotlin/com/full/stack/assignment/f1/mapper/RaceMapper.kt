package com.full.stack.assignment.f1.mapper

import com.full.stack.assignment.f1.data.cache.entity.DriverEntity
import com.full.stack.assignment.f1.data.cache.entity.RaceEntity
import com.full.stack.assignment.f1.data.cache.entity.SeasonEntity
import com.full.stack.assignment.f1.model.Race
import org.springframework.stereotype.Component

@Component
class RaceMapper(
    private val circuitMapper: CircuitMapper,
    private val driverMapper: DriverMapper,
    private val constructorMapper: ConstructorMapper
): Mapper<Race, RaceEntity> {
    override fun toDomain(entity: RaceEntity): Race {
        return Race(
            seasonYear = entity.seasonYear,
            round = entity.round,
            raceName = entity.raceName,
            circuit = circuitMapper.toDomain(entity.circuit),
            date = entity.date,
            winningDriver = driverMapper.toDomain(entity.winningDriver),
            winningConstructor = constructorMapper.toDomain(entity.winningConstructor)
        )
    }

    override fun toEntity(domain: Race): RaceEntity {
        return RaceEntity(
            seasonYear = domain.seasonYear,
            season = SeasonEntity(year = domain.seasonYear, champion = DriverEntity()),
            round = domain.round,
            raceName = domain.raceName,
            circuit = circuitMapper.toEntity(domain.circuit),
            date = domain.date,
            winningDriver = driverMapper.toEntity(domain.winningDriver),
            winningConstructor = constructorMapper.toEntity(domain.winningConstructor)
        )
    }
}