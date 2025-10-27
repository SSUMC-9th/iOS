//
//  MovieSchedule.swift
//  mega
//
//  Created by 이경민 on 10/27/25.
//

import Foundation

struct MovieSchedule {
    let movies: [MovieDomain]
}

struct MovieDomain {
    let id: String
    let title: String
    let ageRating: String
    let schedules: [ScheduleDomain]
}

struct ScheduleDomain {
    let date: Date?
    let areas: [AreaDomain]
}

struct AreaDomain {
    let name: String
    let items: [ScheduleItemDomain]
}

struct ScheduleItemDomain {
    let auditorium: String
    let format: String
    let showtimes: [ShowtimeDomain]
}

struct ShowtimeDomain {
    let start: String
    let end: String
    let available: Int
    let total: Int
}
