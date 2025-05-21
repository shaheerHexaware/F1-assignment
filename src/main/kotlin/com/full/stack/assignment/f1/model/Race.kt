package com.full.stack.assignment.f1.model

data class Race(
    val season: Int,
    val round: Int,
    val raceName: String,
    val circuit: Circuit,
    val date: String,
    val time: String?,
    val winningDriver: Driver,
    val winningConstructor: Constructor
)
