package com.full.stack.assignment.f1.service

import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Service

@Service
class OnStartDataInitializationService(
    private val f1Service: F1Service,
    @Value("\${data.initializer.start.year}") private val startYear: Int,
    @Value("\${data.initializer.end.year}") private val endYear: Int? = null,
) {
    private val logger = LoggerFactory.getLogger(javaClass)

    fun initializeF1Data() {
        try {
            val endYear = endYear ?: java.time.Year.now().value

            logger.info("Initializing data for the period $startYear to $endYear")
            f1Service.getSeasons(startYear, endYear)
        } catch (e: Exception) {
            logger.error("Error while initializing data: $e")
        }
    }
}
