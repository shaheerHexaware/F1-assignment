package com.full.stack.assignment.f1.data.cache.entity

import jakarta.persistence.Entity
import jakarta.persistence.Id
import jakarta.persistence.OneToMany
import jakarta.persistence.Table

@Entity
@Table(name = "constructors")
data class ConstructorEntity(
    @Id
    val id: String,
    val name: String,
    val nationality: String,
    @OneToMany(mappedBy = "winningConstructor")
    val racesWon: MutableSet<RaceEntity> = mutableSetOf(),
) {
    constructor() : this("", "", "", mutableSetOf())
}
