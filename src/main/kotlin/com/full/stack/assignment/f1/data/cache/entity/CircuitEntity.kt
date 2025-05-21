package com.full.stack.assignment.f1.data.cache.entity

import jakarta.persistence.Column
import jakarta.persistence.Embeddable
import jakarta.persistence.Embedded
import jakarta.persistence.Entity
import jakarta.persistence.Id
import jakarta.persistence.OneToMany
import jakarta.persistence.Table

@Entity
@Table(name = "circuits")
data class CircuitEntity(
    @Id
    val id: String,

    @Column(name = "circuit_name")
    val name: String,

    @Embedded
    val location: CircuitLocationEntity,

    @OneToMany(mappedBy = "circuit")
    val races: MutableSet<RaceEntity> = mutableSetOf()
) {
    constructor() : this("", "", CircuitLocationEntity(), mutableSetOf())
}

@Embeddable
data class CircuitLocationEntity(
    val locality: String,
    val country: String
) {
    constructor() : this("", "")
}