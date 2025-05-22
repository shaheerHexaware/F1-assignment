package com.full.stack.assignment.f1.data.cache.mapper

import com.full.stack.assignment.f1.data.cache.entity.DriverEntity
import com.full.stack.assignment.f1.model.Driver
import org.springframework.stereotype.Component

@Component
class DriverMapper: Mapper<Driver, DriverEntity> {
    override fun toDomain(entity: DriverEntity): Driver {
        return Driver(
            id = entity.id,
            code = entity.code,
            firstName = entity.firstName,
            lastName = entity.lastName,
            dateOfBirth = entity.dateOfBirth,
            nationality = entity.nationality,
        )
    }

    override fun toEntity(domain: Driver): DriverEntity {
        return DriverEntity(
            id = domain.id,
            code = domain.code,
            firstName = domain.firstName,
            lastName = domain.lastName,
            dateOfBirth = domain.dateOfBirth,
            nationality = domain.nationality,
        )
    }
}