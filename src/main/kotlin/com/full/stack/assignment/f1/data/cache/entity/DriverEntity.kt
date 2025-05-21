package com.full.stack.assignment.f1.data.cache.entity

import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.Id
import jakarta.persistence.Table

@Entity
@Table(name = "drivers")
data class DriverEntity(
    @Id
    val id: String,

    val code: String?,

    @Column(name = "first_name")
    val firstName: String,

    @Column(name = "last_name")
    val lastName: String,

    @Column(name = "date_of_birth")
    val dateOfBirth: String,

    val nationality: String,
)