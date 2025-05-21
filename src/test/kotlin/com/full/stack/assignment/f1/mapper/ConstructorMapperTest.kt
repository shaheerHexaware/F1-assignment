package com.full.stack.assignment.f1.mapper

import com.full.stack.assignment.f1.data.cache.entity.ConstructorEntity
import com.full.stack.assignment.f1.model.Constructor
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test

class ConstructorMapperTest {

    private val mapper = ConstructorMapper()

    @Test
    fun `toDomain should correctly map ConstructorEntity to Constructor`() {
        val entity = ConstructorEntity(
            id = "constructor-123",
            name = "Red Bull Racing",
            nationality = "Austrian"
        )

        val domain = mapper.toDomain(entity)

        assertEquals(entity.id, domain.id)
        assertEquals(entity.name, domain.name)
        assertEquals(entity.nationality, domain.nationality)
    }

    @Test
    fun `toEntity should correctly map Constructor to ConstructorEntity`() {
        val domain = Constructor(
            id = "constructor-456",
            name = "Mercedes-AMG Petronas",
            nationality = "German"
        )

        val entity = mapper.toEntity(domain)

        assertEquals(domain.id, entity.id)
        assertEquals(domain.name, entity.name)
        assertEquals(domain.nationality, entity.nationality)
    }
}