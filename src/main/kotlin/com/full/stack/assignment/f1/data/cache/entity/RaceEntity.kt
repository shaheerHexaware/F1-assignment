package com.full.stack.assignment.f1.data.cache.entity

import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.GeneratedValue
import jakarta.persistence.GenerationType
import jakarta.persistence.Id
import jakarta.persistence.JoinColumn
import jakarta.persistence.ManyToOne
import jakarta.persistence.Table

@Entity
@Table(name = "races")
data class RaceEntity(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,
    @Column(name = "season_year", insertable = false, updatable = false)
    val seasonYear: Int,
    val round: Int,
    @Column(name = "race_name")
    val raceName: String,
    val date: String,
    @ManyToOne
    @JoinColumn(name = "circuit_id")
    val circuit: CircuitEntity,
    @ManyToOne
    @JoinColumn(name = "winning_driver_id")
    val winningDriver: DriverEntity,
    @ManyToOne
    @JoinColumn(name = "winning_constructor_id")
    val winningConstructor: ConstructorEntity,
    @ManyToOne
    @JoinColumn(name = "season_year")
    val season: SeasonEntity,
) {
    constructor() : this(
        null, 0, 0, "", "", CircuitEntity(), DriverEntity(), ConstructorEntity(), SeasonEntity(),
    )
}
