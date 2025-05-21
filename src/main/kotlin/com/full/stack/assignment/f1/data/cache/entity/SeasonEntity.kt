package com.full.stack.assignment.f1.data.cache.entity

import jakarta.persistence.Entity
import jakarta.persistence.FetchType
import jakarta.persistence.Id
import jakarta.persistence.JoinColumn
import jakarta.persistence.ManyToOne
import jakarta.persistence.OneToMany
import jakarta.persistence.Table


@Entity
@Table(name = "seasons")
data class SeasonEntity(
    @Id
    val year: Int,

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "champion_id")
    val champion: DriverEntity,

    @OneToMany(mappedBy = "season")
    val races: MutableSet<RaceEntity> = mutableSetOf()
) {
    constructor() : this(0, DriverEntity())
}