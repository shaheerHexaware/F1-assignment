package com.full.stack.assignment.f1.mapper

import com.full.stack.assignment.f1.Dummies.createCircuit
import com.full.stack.assignment.f1.Dummies.createCircuitEntity
import com.full.stack.assignment.f1.Dummies.createConstructor
import com.full.stack.assignment.f1.Dummies.createConstructorEntity
import com.full.stack.assignment.f1.Dummies.createDriver
import com.full.stack.assignment.f1.Dummies.createDriverEntity
import com.full.stack.assignment.f1.Dummies.createRace
import com.full.stack.assignment.f1.Dummies.createRaceEntity
import com.full.stack.assignment.f1.data.cache.mapper.CircuitMapper
import com.full.stack.assignment.f1.data.cache.mapper.ConstructorMapper
import com.full.stack.assignment.f1.data.cache.mapper.DriverMapper
import com.full.stack.assignment.f1.data.cache.mapper.RaceMapper
import io.mockk.every
import io.mockk.mockk
import io.mockk.verify
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test

class RaceMapperTest {
    private val circuitMapper: CircuitMapper = mockk()
    private val driverMapper: DriverMapper = mockk()
    private val constructorMapper: ConstructorMapper = mockk()

    private val raceMapper = RaceMapper(circuitMapper, driverMapper, constructorMapper)

    @Test
    fun `toDomain should correctly map RaceEntity to Race`() {
        val circuitEntity = createCircuitEntity()
        val winningDriverEntity = createDriverEntity()
        val winningConstructorEntity = createConstructorEntity()
        val raceEntity =
            createRaceEntity(
                circuitEntity = circuitEntity,
                driverEntity = winningDriverEntity,
                constructorEntity = winningConstructorEntity,
            )

        val circuit = createCircuit()
        val winningDriver = createDriver()
        val winningConstructor = createConstructor()

        every { circuitMapper.toDomain(circuitEntity) } returns circuit
        every { driverMapper.toDomain(winningDriverEntity) } returns winningDriver
        every { constructorMapper.toDomain(winningConstructorEntity) } returns winningConstructor

        val race = raceMapper.toDomain(raceEntity)

        assertEquals(raceEntity.seasonYear, race.seasonYear)
        assertEquals(raceEntity.round, race.round)
        assertEquals(raceEntity.raceName, race.raceName)
        assertEquals(circuit, race.circuit)
        assertEquals(winningDriver, race.winningDriver)
        assertEquals(winningConstructor, race.winningConstructor)

        verify(exactly = 1) { circuitMapper.toDomain(circuitEntity) }
        verify(exactly = 1) { driverMapper.toDomain(winningDriverEntity) }
        verify(exactly = 1) { constructorMapper.toDomain(winningConstructorEntity) }
    }

    @Test
    fun `toEntity should correctly map Race to RaceEntity`() {
        val circuit = createCircuit()
        val driver = createDriver()
        val constructor = createConstructor()
        val race =
            createRace(
                circuit = circuit,
                driver = driver,
                constructor = constructor,
            )

        val circuitEntity = createCircuitEntity()
        val driverEntity = createDriverEntity()
        val constructorEntity = createConstructorEntity()

        every { circuitMapper.toEntity(circuit) } returns circuitEntity
        every { driverMapper.toEntity(driver) } returns driverEntity
        every { constructorMapper.toEntity(constructor) } returns constructorEntity

        val raceEntity = raceMapper.toEntity(race)

        assertEquals(race.seasonYear, raceEntity.seasonYear)
        assertEquals(race.round, raceEntity.round)
        assertEquals(race.raceName, raceEntity.raceName)
        assertEquals(circuitEntity, raceEntity.circuit)
        assertEquals(driverEntity, raceEntity.winningDriver)
        assertEquals(constructorEntity, raceEntity.winningConstructor)

        verify(exactly = 1) { circuitMapper.toEntity(circuit) }
        verify(exactly = 1) { driverMapper.toEntity(driver) }
        verify(exactly = 1) { constructorMapper.toEntity(constructor) }
    }
}
