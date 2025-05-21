package com.full.stack.assignment.f1.model

import com.fasterxml.jackson.annotation.JsonProperty

data class Circuit(
    @JsonProperty("circuitId")
    val id: String,
    @JsonProperty("circuitName")
    val name: String,
    @JsonProperty("Location")
    val location: CircuitLocation
)

data class CircuitLocation(
    @JsonProperty("locality")
    val locality: String,
    @JsonProperty("country")
    val country: String
)