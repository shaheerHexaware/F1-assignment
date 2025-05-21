package com.full.stack.assignment.f1.service

import com.full.stack.assignment.f1.data.remote.RemoteApiRepository
import com.full.stack.assignment.f1.model.Season
import org.springframework.stereotype.Service

@Service
class F1ServiceImpl(
    private val remoteApiRepository: RemoteApiRepository,
): F1Service {
    override fun getSeasons(
        from: Int,
        to: Int
    ): List<Season> {
        return (from .. to).map { year ->
            remoteApiRepository.getSeason(year)
        }
    }
}