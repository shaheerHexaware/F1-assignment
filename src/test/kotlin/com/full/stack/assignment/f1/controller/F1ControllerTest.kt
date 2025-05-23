package com.full.stack.assignment.f1.controller

import com.full.stack.assignment.f1.Dummies.createRace
import com.full.stack.assignment.f1.Dummies.createSeason
import com.full.stack.assignment.f1.InvalidDateRangeException
import com.full.stack.assignment.f1.service.F1Service
import io.mockk.every
import io.mockk.mockk
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import java.time.Year
import kotlin.test.assertEquals
import kotlin.test.assertFailsWith

class F1ControllerTest {
    private lateinit var f1Service: F1Service
    private lateinit var controller: F1Controller

    private val currentYear = Year.now().value

    @BeforeEach
    fun setup() {
        f1Service = mockk()
        controller = F1Controller(f1Service)
    }

    @Test
    fun `getSeasonsWithChampions should return seasons for valid range`() {
        val from = 2010
        val to = 2020

        val expectedSeasons = List(11) { createSeason(year = from + it) }

        every { f1Service.getSeasons(from, to) } returns expectedSeasons

        val result = controller.getSeasonsWithChampions(from, to)

        assertEquals(expectedSeasons, result)
    }

    @Test
    fun `getSeasonsWithChampions should use currentYear as default to parameter`() {
        val from = 2010

        val expectedSeasons = List(currentYear - from + 1) { createSeason(year = from + it) }

        every { f1Service.getSeasons(from, currentYear) } returns expectedSeasons

        val result = controller.getSeasonsWithChampions(from, null)

        assert(result.any { it.year == currentYear })
        assertEquals(expectedSeasons, result)
    }

    @Test
    fun `getSeasonsWithChampions should throw exception when to year is greater than current year`() {
        val from = 2010
        val to = currentYear + 1

        val exception =
            assertFailsWith<InvalidDateRangeException> {
                controller.getSeasonsWithChampions(from, to)
            }
        assertEquals("To year ($to) cannot be greater than ($currentYear)", exception.message)
    }

    @Test
    fun `getSeasonsWithChampions should throw exception when from year is greater than to year`() {
        val from = 2020
        val to = 2010

        val exception =
            assertFailsWith<InvalidDateRangeException> {
                controller.getSeasonsWithChampions(from, to)
            }
        assertEquals("From year ($from) cannot be greater than to year ($to)", exception.message)
    }

    @Test
    fun `getSeasonsWithChampions should throw exception when from years are before first Formula 1 year`() {
        val from = 1940
        val to = 1960

        val exception =
            assertFailsWith<InvalidDateRangeException> {
                controller.getSeasonsWithChampions(from, to)
            }
        assertEquals("Invalid range. Range should start from year that is >= $FIRST_FORMULA1_YEAR", exception.message)
    }

    @Test
    fun `getSeasonsWithChampions should throw exception when complete range is before first Formula 1 year`() {
        val from = 1940
        val to = 1949

        val exception =
            assertFailsWith<InvalidDateRangeException> {
                controller.getSeasonsWithChampions(from, to)
            }
        assertEquals("Invalid range. Range should start from year that is >= $FIRST_FORMULA1_YEAR", exception.message)
    }

    @Test
    fun `getSeasonRaces should return races for valid year`() {
        val year = 2020
        val expectedRaces = List(22) { createRace(seasonYear = year) }
        every { f1Service.getSeasonRaces(year) } returns expectedRaces

        val result = controller.getSeasonRaces(year)

        assertEquals(expectedRaces, result)
    }

    @Test
    fun `getSeasonRaces should throw exception when year is greater than current year`() {
        val year = currentYear + 1

        val exception =
            assertFailsWith<InvalidDateRangeException> {
                controller.getSeasonRaces(year)
            }
        assertEquals("Year ($year) cannot be greater than ($currentYear)", exception.message)
    }

    @Test
    fun `getSeasonRaces should throw exception when year is before first Formula 1 year`() {
        val year = 1940

        val exception =
            assertFailsWith<InvalidDateRangeException> {
                controller.getSeasonRaces(year)
            }
        assertEquals("Invalid year. Year should be >= $FIRST_FORMULA1_YEAR", exception.message)
    }
}
