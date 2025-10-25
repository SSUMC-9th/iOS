//
//  LocationScheduleView.swift
//  mega
//
//  Created by 이경민 on 10/6/25.
//

import SwiftUI

import SwiftUI

struct LocationScheduleView: View {
    let locationSchedule: LocationSchedule
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(locationSchedule.locationName)
                .font(.bold18)
            
            ForEach(locationSchedule.schedules) { schedule in
                TheaterScheduleView(schedule: schedule)
            }
        }
    }
}

#Preview {
    let mockShowtimes: [Showtime] = [
        .init(startTime: "11:30", endTime: "~13:58", availableSeats: 109, totalSeats: 116),
        .init(startTime: "14:20", endTime: "~16:48", availableSeats: 19, totalSeats: 116)
    ]
    let mockSchedule = TheaterSchedule(theaterName: "테스트 1관", screenType: "2D", showtimes: mockShowtimes)
    let mockLocation = LocationSchedule(locationName: "강남", schedules: [mockSchedule])
    
    return LocationScheduleView(locationSchedule: mockLocation)
}
