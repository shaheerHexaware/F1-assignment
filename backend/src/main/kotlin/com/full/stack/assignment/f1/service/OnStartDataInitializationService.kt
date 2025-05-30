package com.full.stack.assignment.f1.service

import com.full.stack.assignment.f1.controller.F1Controller
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Service

@Service
class OnStartDataInitializationService(
    private val f1Controller: F1Controller,
    @Value("\${data.initializer.start.year}") private val startYear: Int,
    @Value("\${data.initializer.end.year}") private val endYear: Int? = null,
) {
    fun initializeF1Data() {
        try {
            f1Controller.getSeasonsWithChampions(startYear, endYear)
        } catch (e: Exception) {
            println("Failed to initialize F1 data: $e")
        }
    }
}
