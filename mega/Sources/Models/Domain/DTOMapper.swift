//
//  DTOMapper.swift
//  mega
//
//  Created by 이경민 on 10/27/25.
//

import Foundation

extension MovieScheduleResponse {
    func toDomain() -> MovieSchedule {
        MovieSchedule(movies: data?.movies?.map { $0.toDomain() } ?? [])
    }
}

extension MovieDTO {
    func toDomain() -> MovieDomain {
        MovieDomain(
            id: id ?? "",
            title: title ?? "",
            ageRating: ageRating ?? "",
            schedules: schedules?.map { $0.toDomain() } ?? []
        )
    }
}

extension ScheduleDTO {
    func toDomain() -> ScheduleDomain {
        ScheduleDomain(
            date: DateFormatter.apiDateFormatter.date(from: date ?? ""),
            areas: areas?.map { $0.toDomain() } ?? []
        )
    }
}

extension AreaDTO {
    func toDomain() -> AreaDomain {
        AreaDomain(
            name: area ?? "",
            items: items?.map { $0.toDomain() } ?? []
        )
    }
}

extension ScheduleItemDTO {
    func toDomain() -> ScheduleItemDomain {
        ScheduleItemDomain(
            auditorium: auditorium ?? "",
            format: format ?? "",
            showtimes: showtimes?.map { $0.toDomain() } ?? []
        )
    }
}

extension ShowtimeDTO {
    func toDomain() -> ShowtimeDomain {
        ShowtimeDomain(
            start: start ?? "",
            end: end ?? "",
            available: available ?? 0,
            total: total ?? 0
        )
    }
}

