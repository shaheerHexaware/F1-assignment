package com.full.stack.assignment.f1.model

import com.fasterxml.jackson.annotation.JsonProperty

data class Constructor(
    @JsonProperty("constructorId")
    val id: String,
    @JsonProperty("name")
    val name: String,
    @JsonProperty("nationality")
    val nationality: String,
)
