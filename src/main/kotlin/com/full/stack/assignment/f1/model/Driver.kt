package com.full.stack.assignment.f1.model

import com.fasterxml.jackson.annotation.JsonProperty

data class Driver(
    @JsonProperty("driverId")
    val id: String,
    @JsonProperty("code")
    val code: String?,
    @JsonProperty("givenName")
    val firstName: String,
    @JsonProperty("familyName")
    val lastName: String,
    @JsonProperty("dateOfBirth")
    val dateOfBirth: String,
    @JsonProperty("nationality")
    val nationality: String
)