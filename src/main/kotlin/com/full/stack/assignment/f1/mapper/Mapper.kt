package com.full.stack.assignment.f1.mapper

interface Mapper<Domain, Entity> {
    fun toDomain(entity: Entity): Domain
    fun toEntity(domain: Domain): Entity
}