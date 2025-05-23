package com.full.stack.assignment.f1.data.cache.repository

import com.full.stack.assignment.f1.data.cache.entity.ConstructorEntity
import org.springframework.data.jpa.repository.JpaRepository

interface ConstructorCacheRepository : JpaRepository<ConstructorEntity, String>
