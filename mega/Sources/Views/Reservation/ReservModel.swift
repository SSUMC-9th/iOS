//
//  ReservModel.swift
//  mega
//
//  Created by 이경민 on 10/5/25.
//

import SwiftUI
import Foundation

struct ReservModel:Identifiable{
    let id: UUID = UUID()
    let movieImage: Image
    let movieName: String
    let movieEngName: String
    let movieReserCount: String
}

struct Showtime: Identifiable, Hashable {
    let id = UUID()
    let startTime: String
    let endTime: String
    let availableSeats: Int
    let totalSeats: Int
}

struct TheaterSchedule: Identifiable, Hashable {
    let id = UUID()
    let theaterName: String
    let screenType: String
    let showtimes: [Showtime]
}

struct LocationSchedule: Identifiable, Hashable {
    let id = UUID()
    let locationName: String
    let schedules: [TheaterSchedule]
}
