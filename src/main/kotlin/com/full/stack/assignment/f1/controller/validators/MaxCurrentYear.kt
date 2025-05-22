package com.full.stack.assignment.f1.controller.validators

import jakarta.validation.Constraint
import kotlin.reflect.KClass

@Target(AnnotationTarget.VALUE_PARAMETER)
@Retention(AnnotationRetention.RUNTIME)
@Constraint(validatedBy = [MaxCurrentYearValidator::class])
annotation class MaxCurrentYear(
    val message: String = "Year cannot be greater than current year",
    val groups: Array<KClass<*>> = [],
    val payload: Array<KClass<*>> = []
)