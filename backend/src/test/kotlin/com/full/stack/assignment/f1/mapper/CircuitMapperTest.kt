package com.full.stack.assignment.f1.mapper

import com.full.stack.assignment.f1.data.cache.entity.CircuitEntity
import com.full.stack.assignment.f1.data.cache.entity.CircuitLocationEntity
import com.full.stack.assignment.f1.data.cache.mapper.CircuitMapper
import com.full.stack.assignment.f1.model.Circuit
import com.full.stack.assignment.f1.model.CircuitLocation
import io.mockk.MockKAnnotations
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test

class CircuitMapperTest {
    private lateinit var circuitMapper: CircuitMapper

    @BeforeEach
    fun setUp() {
        MockKAnnotations.init(this)
        circuitMapper = CircuitMapper() // Assuming a direct implementation without dependencies
    }

    @Test
    fun `toEntity should correctly map Circuit to CircuitEntity`() {
        val circuit =
            Circuit(
                id = "monaco",
                name = "Circuit de Monaco",
                location =
                    CircuitLocation(
                        locality = "Monte Carlo",
                        country = "Monaco",
                    ),
            )

        // When
        val result = circuitMapper.toEntity(circuit)

        // Then
        assertEquals(circuit.id, result.id)
        assertEquals(circuit.name, result.name)
        assertEquals(circuit.location.locality, result.location.locality)
        assertEquals(circuit.location.country, result.location.country)
    }

    @Test
    fun `toDomain should correctly map CircuitEntity to Circuit`() {
        // Given
        val circuitEntity =
            CircuitEntity(
                id = "silverstone",
                name = "Silverstone Circuit",
                location =
                    CircuitLocationEntity(
                        locality = "Monte Carlo",
                        country = "Monaco",
                    ),
            )

        // When
        val result = circuitMapper.toDomain(circuitEntity)

        // Then
        assertEquals(circuitEntity.id, result.id)
        assertEquals(circuitEntity.name, result.name)
        assertEquals(circuitEntity.location.locality, result.location.locality)
        assertEquals(circuitEntity.location.country, result.location.country)
    }
}
