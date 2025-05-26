package com.full.stack.assignment.f1.data.cache.mapper

import com.full.stack.assignment.f1.data.cache.entity.ConstructorEntity
import com.full.stack.assignment.f1.model.Constructor
import org.springframework.stereotype.Component

@Component
class ConstructorMapper : Mapper<Constructor, ConstructorEntity> {
    override fun toDomain(entity: ConstructorEntity): Constructor {
        return Constructor(
            id = entity.id,
            name = entity.name,
            nationality = entity.nationality,
        )
    }

    override fun toEntity(domain: Constructor): ConstructorEntity {
        return ConstructorEntity(
            id = domain.id,
            name = domain.name,
            nationality = domain.nationality,
        )
    }
}
