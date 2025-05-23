package com.full.stack.assignment.f1.controller.validators

import io.mockk.mockk
import jakarta.validation.ConstraintValidatorContext
import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import java.time.Year

class MaxCurrentYearValidatorTest {

    private lateinit var validator: MaxCurrentYearValidator
    private lateinit var context: ConstraintValidatorContext

    @BeforeEach
    fun setUp() {
        validator = MaxCurrentYearValidator()
        context = mockk<ConstraintValidatorContext>(relaxed = true)
    }

    @Test
    fun `should return true when value is null`() {
        val value: Int? = null

        val result = validator.isValid(value, context)

        assertTrue(result)
    }

    @Test
    fun `should return true when value is less than current year`() {
        val value = Year.now().value - 1

        val result = validator.isValid(value, context)

        assertTrue(result)
    }

    @Test
    fun `should return true when value is equal to current year`() {
        val value = Year.now().value

        val result = validator.isValid(value, context)

        assertTrue(result)
    }

    @Test
    fun `should return false when value is greater than current year`() {
        val value = Year.now().value + 1

        val result = validator.isValid(value, context)

        assertFalse(result)
    }
}