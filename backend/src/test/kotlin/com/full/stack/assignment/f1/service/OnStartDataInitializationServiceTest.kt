package com.full.stack.assignment.f1.service

import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.mockito.Mock
import org.mockito.Mockito.*
import org.mockito.junit.jupiter.MockitoExtension
import java.time.Year

@ExtendWith(MockitoExtension::class)
class OnStartDataInitializationServiceTest {

    @Mock
    private lateinit var f1Service: F1Service

    private val startYear = 2020
    private val endYear = 2023
    
    @Test
    fun `initializeF1Data should call f1Service with correct years`() {
        val service = OnStartDataInitializationService(f1Service, startYear, endYear)
        
        service.initializeF1Data()
        
        verify(f1Service).getSeasons(startYear, endYear)
    }
    
    @Test
    fun `initializeF1Data should use current year when endYear is null`() {
        val currentYear = Year.now().value
        val service = OnStartDataInitializationService(f1Service, startYear, null)
        
        service.initializeF1Data()
        
        verify(f1Service).getSeasons(startYear, currentYear)
    }
    
    @Test
    fun `initializeF1Data should handle exceptions`() {
        val service = OnStartDataInitializationService(f1Service, startYear, endYear)
        val exception = RuntimeException("Test exception")
        `when`(f1Service.getSeasons(anyInt(), anyInt())).thenThrow(exception)
        
        service.initializeF1Data()
    }
}