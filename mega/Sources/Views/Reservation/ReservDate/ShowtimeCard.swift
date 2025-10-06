//
//  ShowtimeCard.swift
//  mega
//
//  Created by 이경민 on 10/6/25.
//

import SwiftUI

struct ShowtimeCard: View {
    let showtime: Showtime
    
    var body: some View {
        VStack(spacing: 4) {
            Text(showtime.startTime)
                .font(.bold18)
            
            Text(showtime.endTime)
                .font(.regular12)
                .foregroundStyle(Color("gray03"))
            
            HStack(spacing: 0) {
                Text("\(showtime.availableSeats)")
                    .font(.semiBold14)
                    .foregroundStyle(Color("purple04"))
                Text(" / \(showtime.totalSeats)")
                    .font(.semiBold14)
                    .foregroundStyle(Color("gray04"))
            }
        }
        .frame(width:75, height: 86)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("gray02"), lineWidth: 1)
        )
    }
}


#Preview {
    let mockShowtime = Showtime(startTime: "11:30", endTime: "~13:58", availableSeats: 109, totalSeats: 116)
    
    return HStack {
        ShowtimeCard(showtime: mockShowtime)
        ShowtimeCard(showtime: mockShowtime)
        ShowtimeCard(showtime: mockShowtime)
        ShowtimeCard(showtime: mockShowtime)
    }
    .padding()
}
