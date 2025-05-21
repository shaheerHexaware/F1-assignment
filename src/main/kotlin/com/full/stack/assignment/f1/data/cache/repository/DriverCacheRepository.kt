package com.full.stack.assignment.f1.data.cache.repository

import com.full.stack.assignment.f1.data.cache.entity.DriverEntity
import org.springframework.data.jpa.repository.JpaRepository

interface DriverCacheRepository : JpaRepository<DriverEntity, String>