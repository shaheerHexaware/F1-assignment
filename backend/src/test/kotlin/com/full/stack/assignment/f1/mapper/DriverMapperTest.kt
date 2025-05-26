package com.full.stack.assignment.f1.mapper

import com.full.stack.assignment.f1.data.cache.entity.DriverEntity
import com.full.stack.assignment.f1.data.cache.mapper.DriverMapper
import com.full.stack.assignment.f1.model.Driver
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test

class DriverMapperTest {
    private val mapper = DriverMapper()

    @Test
    fun `toDomain should correctly map DriverEntity to Driver`() {
        val entity =
            DriverEntity(
                id = "hamilton",
                code = "HAM",
                firstName = "Lewis",
                lastName = "Hamilton",
                dateOfBirth = "2023-03-05",
                nationality = "British",
            )

        val domain = mapper.toDomain(entity)

        assertEquals(entity.id, domain.id)
        assertEquals(entity.code, domain.code)
        assertEquals(entity.firstName, domain.firstName)
        assertEquals(entity.lastName, domain.lastName)
        assertEquals(entity.dateOfBirth, domain.dateOfBirth)
        assertEquals(entity.nationality, domain.nationality)
    }

    @Test
    fun `toEntity should correctly map Driver to DriverEntity`() {
        val domain =
            Driver(
                id = "hamilton",
                code = "HAM",
                firstName = "Lewis",
                lastName = "Hamilton",
                dateOfBirth = "2023-03-05",
                nationality = "British",
            )

        val entity = mapper.toEntity(domain)

        assertEquals(domain.id, entity.id)
        assertEquals(domain.code, entity.code)
        assertEquals(domain.firstName, entity.firstName)
        assertEquals(domain.lastName, entity.lastName)
        assertEquals(domain.dateOfBirth, entity.dateOfBirth)
        assertEquals(domain.nationality, entity.nationality)
    }
}
