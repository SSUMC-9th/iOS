//
//  TheaterScheduleView.swift
//  mega
//
//  Created by 이경민 on 10/6/25.
//

import SwiftUI

struct TheaterScheduleView: View {
    let schedule: TheaterSchedule
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(schedule.theaterName)
                    .font(.bold18)
                Spacer()
                Text(schedule.screenType)
                    .font(.semiBold14)
                    .foregroundStyle(Color("gray04"))
            }
            
            LazyVGrid(columns: columns, spacing: 36) {
                ForEach(schedule.showtimes) { showtime in
                    ShowtimeCard(showtime: showtime)
                }
            }
        }
    }
}

#Preview {
    let mockShowtimes: [Showtime] = [
        .init(startTime: "11:30", endTime: "~13:58", availableSeats: 109, totalSeats: 116),
        .init(startTime: "14:20", endTime: "~16:48", availableSeats: 19, totalSeats: 116),
        .init(startTime: "17:05", endTime: "~19:28", availableSeats: 1, totalSeats: 116)
    ]
    let mockSchedule = TheaterSchedule(theaterName: "크리클라이너 1관", screenType: "2D", showtimes: mockShowtimes)
    
    return TheaterScheduleView(schedule: mockSchedule)
}
