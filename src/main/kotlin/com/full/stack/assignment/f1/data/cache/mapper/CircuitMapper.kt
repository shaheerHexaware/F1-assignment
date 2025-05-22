package com.full.stack.assignment.f1.data.cache.mapper

import com.full.stack.assignment.f1.data.cache.entity.CircuitEntity
import com.full.stack.assignment.f1.data.cache.entity.CircuitLocationEntity
import com.full.stack.assignment.f1.model.Circuit
import com.full.stack.assignment.f1.model.CircuitLocation
import org.springframework.stereotype.Component

@Component
class CircuitMapper: Mapper<Circuit, CircuitEntity> {
    override fun toDomain(entity: CircuitEntity): Circuit {
        return Circuit(
            id = entity.id,
            name = entity.name,
            location = CircuitLocation(
                locality = entity.location.locality,
                country = entity.location.country,
            ),
        )
    }

    override fun toEntity(domain: Circuit): CircuitEntity {
        return CircuitEntity(
            id = domain.id,
            name = domain.name,
            location = CircuitLocationEntity(
                locality = domain.location.locality,
                country = domain.location.country,
            )
        )
    }
}