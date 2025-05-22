package com.full.stack.assignment.f1.controller.validators

import jakarta.validation.ConstraintValidator
import jakarta.validation.ConstraintValidatorContext
import java.time.Year

class MaxCurrentYearValidator : ConstraintValidator<MaxCurrentYear, Int?> {
    override fun isValid(value: Int?, context: ConstraintValidatorContext): Boolean {
        if (value == null) return true
        val currentYear = Year.now().value
        return value <= currentYear
    }
}
