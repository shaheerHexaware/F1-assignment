package com.full.stack.assignment.f1.data.cache.repository

import com.full.stack.assignment.f1.data.cache.entity.CircuitEntity
import org.springframework.data.jpa.repository.JpaRepository

interface CircuitCacheRepository : JpaRepository<CircuitEntity, String>
