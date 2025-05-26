package com.full.stack.assignment.f1.mapper

import com.full.stack.assignment.f1.Dummies.createDriver
import com.full.stack.assignment.f1.Dummies.createDriverEntity
import com.full.stack.assignment.f1.Dummies.createSeason
import com.full.stack.assignment.f1.Dummies.createSeasonEntity
import com.full.stack.assignment.f1.data.cache.mapper.DriverMapper
import com.full.stack.assignment.f1.data.cache.mapper.SeasonMapper
import io.mockk.every
import io.mockk.mockk
import io.mockk.verify
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test

class SeasonMapperTest {
    private val driverMapper: DriverMapper = mockk()

    private val seasonMapper = SeasonMapper(driverMapper)

    @Test
    fun `toDomain should correctly map SeasonEntity to Season`() {
        val driverEntity = createDriverEntity()
        val seasonEntity = createSeasonEntity(champion = driverEntity)

        val driver = createDriver()

        every { driverMapper.toDomain(driverEntity) } returns driver

        val season = seasonMapper.toDomain(seasonEntity)

        assertEquals(seasonEntity.year, season.year)
        assertEquals(driver, season.champion)

        verify(exactly = 1) { driverMapper.toDomain(driverEntity) }
    }

    @Test
    fun `toEntity should correctly map Season to SeasonEntity`() {
        val driver = createDriver()
        val season = createSeason(champion = driver)

        val driverEntity = createDriverEntity()

        every { driverMapper.toEntity(driver) } returns driverEntity

        val seasonEntity = seasonMapper.toEntity(season)

        assertEquals(season.year, seasonEntity.year)
        assertEquals(driverEntity, seasonEntity.champion)

        verify(exactly = 1) { driverMapper.toEntity(driver) }
    }
}
