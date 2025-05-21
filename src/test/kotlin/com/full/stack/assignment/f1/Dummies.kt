package com.full.stack.assignment.f1

import com.full.stack.assignment.f1.data.cache.entity.CircuitEntity
import com.full.stack.assignment.f1.data.cache.entity.CircuitLocationEntity
import com.full.stack.assignment.f1.data.cache.entity.ConstructorEntity
import com.full.stack.assignment.f1.data.cache.entity.DriverEntity
import com.full.stack.assignment.f1.data.cache.entity.RaceEntity
import com.full.stack.assignment.f1.data.cache.entity.SeasonEntity
import com.full.stack.assignment.f1.model.Circuit
import com.full.stack.assignment.f1.model.CircuitLocation
import com.full.stack.assignment.f1.model.Constructor
import com.full.stack.assignment.f1.model.Driver
import com.full.stack.assignment.f1.model.Race
import com.full.stack.assignment.f1.model.Season
import java.util.Random

const val DUMMY_BASE_URL = "https://races.com/f1/api"
const val DUMMY_DRIVER_ID = "hamilton"
const val DUMMY_CONSTRUCTOR_ID = "redbull"
const val DUMMY_CIRCUIT_ID = "bahrain"
const val DUMMY_RACE_NAME = "Bahrain Grand Prix"
const val DUMMY_SEASON = 2023
const val DUMMY_ROUND = 1

object Dummies {

    fun createCircuit(
        circuitId: String = DUMMY_CIRCUIT_ID,
    ): Circuit {
        return Circuit(
            id = circuitId,
            name = "Bahrain International Circuit",
            location = CircuitLocation(
                locality = "Sakhir",
                country = "Bahrain"
            )
        )
    }

    fun createRace(
        seasonYear: Int = DUMMY_SEASON,
        round: Int = DUMMY_ROUND,
        raceName: String = DUMMY_RACE_NAME,
        circuit: Circuit = createCircuit(),
        driver: Driver = createDriver(),
        constructor: Constructor = createConstructor(),
    ): Race {
        return Race(
            seasonYear = seasonYear,
            round = round,
            raceName = raceName,
            date = "2023-03-05",
            circuit = circuit,
            winningDriver = driver,
            winningConstructor = constructor
        )
    }

    fun createSeason(
        year: Int = DUMMY_SEASON,
        champion: Driver = createDriver(DUMMY_DRIVER_ID)
    ): Season {
        return Season(
            year = year,
            champion = champion
        )
    }

    fun createConstructor(
        constructorId: String = DUMMY_CONSTRUCTOR_ID,
    ): Constructor {
        return Constructor(
            id = constructorId,
            name = "Red Bull Racing",
            nationality = "Austrian"
        )
    }

    fun createDriver(
        driverId: String = DUMMY_DRIVER_ID,
    ): Driver {
        return Driver(
            id = driverId,
            code = driverId.uppercase().take(3),
            firstName = "First",
            lastName = "Last",
            dateOfBirth = "1985-01-01",
            nationality = "British"
        )
    }

    fun createCircuitEntity(
        circuitId: String = DUMMY_CIRCUIT_ID,
    ): CircuitEntity {
        return CircuitEntity(
            id = circuitId,
            name = "Bahrain International Circuit",
            location = CircuitLocationEntity(
                locality = "Sakhir",
                country = "Bahrain",
            ),
            races = mutableSetOf()
        )
    }

    fun createRaceEntity(
        id: Long = Random().nextLong(),
        seasonYear: Int = DUMMY_SEASON,
        round: Int = DUMMY_ROUND,
        raceName: String = DUMMY_RACE_NAME,
        seasonEntity: SeasonEntity = createSeasonEntity(seasonYear),
        circuitEntity: CircuitEntity = createCircuitEntity(),
        driverEntity: DriverEntity = createDriverEntity(),
        constructorEntity: ConstructorEntity = createConstructorEntity()
    ): RaceEntity {

        return RaceEntity(
            id = id,
            round = round,
            raceName = raceName,
            seasonYear = seasonYear,
            date = "2023-03-05",
            circuit = circuitEntity,
            season = seasonEntity,
            winningDriver = driverEntity,
            winningConstructor = constructorEntity
        )
    }

    fun createSeasonEntity(
        year: Int = DUMMY_SEASON,
        champion: DriverEntity = createDriverEntity(DUMMY_DRIVER_ID)
    ): SeasonEntity {
        return SeasonEntity(
            year = year,
            champion = champion
        )
    }

    fun createDriverEntity(
        driverId: String = DUMMY_DRIVER_ID,
    ): DriverEntity {
        return DriverEntity(
            id = driverId,
            code = driverId.uppercase().take(3),
            firstName = "First",
            lastName = "Last",
            dateOfBirth = "1985-01-01",
            nationality = "British"
        )
    }

    fun createConstructorEntity(
        constructorId: String = DUMMY_CONSTRUCTOR_ID,
    ): ConstructorEntity {
        return ConstructorEntity(
            id = constructorId,
            name = "Red Bull Racing",
            nationality = "Austrian"
        )
    }
}