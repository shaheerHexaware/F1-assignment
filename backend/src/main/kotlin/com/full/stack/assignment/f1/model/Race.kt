package com.full.stack.assignment.f1.model

data class Race(
    val seasonYear: Int,
    val round: Int,
    val raceName: String,
    val circuit: Circuit,
    val date: String,
    val winningDriver: Driver,
    val winningConstructor: Constructor,
)
