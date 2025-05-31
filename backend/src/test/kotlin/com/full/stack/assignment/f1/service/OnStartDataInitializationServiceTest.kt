package com.full.stack.assignment.f1.service

import io.mockk.every
import io.mockk.mockk
import io.mockk.verify
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import java.time.Year

class OnStartDataInitializationServiceTest {
    private lateinit var f1Service: F1Service

    private val startYear = 2020
    private val endYear = 2023

    @BeforeEach
    fun setup() {
        f1Service = mockk()
    }

    @Test
    fun `initializeF1Data should call f1Service with correct years`() {
        val service = OnStartDataInitializationService(f1Service, startYear, endYear)

        service.initializeF1Data()

        verify { f1Service.getSeasons(startYear, endYear) }
    }

    @Test
    fun `initializeF1Data should use current year when endYear is null`() {
        val currentYear = Year.now().value
        val service = OnStartDataInitializationService(f1Service, startYear, null)

        service.initializeF1Data()

        verify { f1Service.getSeasons(startYear, currentYear) }
    }

    @Test
    fun `initializeF1Data should handle exceptions`() {
        val service = OnStartDataInitializationService(f1Service, startYear, endYear)
        val exception = RuntimeException("Test exception")
        every { f1Service.getSeasons(any(), any()) } throws exception

        service.initializeF1Data()
    }
}
