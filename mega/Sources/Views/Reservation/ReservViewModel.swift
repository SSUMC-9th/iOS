//
//  ReservViewModel.swift
//  mega
//
//  Created by 이경민 on 10/5/25.
//

import SwiftUI
import Foundation
import Combine

final class ReservViewModel: ObservableObject{
    @Published var selectedMovie: ReservModel? = nil
    @Published var isTheaterButtonEnabled: Bool = false
    @Published var isDateButtonEnabled: Bool = false
    
    @Published var selectedPlaces: Set<String> = []
    @Published var selectedDate: Date? = nil
    
    @Published var isShowtimesVisible: Bool = false
    
    let dates: [Date] = (0..<7).map { index in
            Calendar.current.date(byAdding: .day, value: index, to: Date())!
        }
    
    var currentIndex:Int=0
    
    let movieViewModel:[ReservModel] = [
        .init(movieImage:.init(.f1), movieName:"F1 더 무비", movieEngName:"F1: The Movie", movieReserCount: "누적관객수 5만"),
        .init(movieImage:.init(.knife), movieName:"귀멸의 칼날", movieEngName:"blade animation", movieReserCount: "누적관객수 1만"),
        .init(movieImage:.init(.ajjulsu), movieName:"어쩔수가없다", movieEngName:"ajjulsu", movieReserCount: "누적관객수 20만"),
        .init(movieImage:.init(.face), movieName:"얼굴", movieEngName:"Face", movieReserCount: "누적관객수 10만"),
        .init(movieImage:.init(.monono), movieName:"모노노케 히메", movieEngName:"Mononoke Hime", movieReserCount: "누적관객수 12만"),
        .init(movieImage:.init(.boss), movieName:"보스", movieEngName:"Boss", movieReserCount: "누적관객수 1만"),
        .init(movieImage:.init(.yadang), movieName:"야당", movieEngName:"Yadang", movieReserCount: "누적관객수 2만"),
        .init(movieImage:.init(.theRoses), movieName:"The Roses", movieEngName:"The Roses", movieReserCount: "누적관객수 3만"),
        ]
    
    let allSchedules: [LocationSchedule] = [
            .init(locationName: "강남", schedules: [
                .init(theaterName: "크리클라이너 1관", screenType: "2D", showtimes: [
                    .init(startTime: "11:30", endTime: "~13:58", availableSeats: 109, totalSeats: 116),
                    .init(startTime: "14:20", endTime: "~16:48", availableSeats: 19, totalSeats: 116),
                    .init(startTime: "17:05", endTime: "~19:28", availableSeats: 1, totalSeats: 116),
                    .init(startTime: "19:45", endTime: "~22:02", availableSeats: 100, totalSeats: 116),
                    .init(startTime: "22:20", endTime: "~00:04", availableSeats: 116, totalSeats: 116)
                ])
            ]),
            .init(locationName: "홍대", schedules: [
                .init(theaterName: "BTS관 (7층 1관) [Laser]", screenType: "2D", showtimes: [
                    .init(startTime: "9:30", endTime: "~11:50", availableSeats: 75, totalSeats: 116),
                    .init(startTime: "12:00", endTime: "~14:26", availableSeats: 102, totalSeats: 116),
                    .init(startTime: "14:45", endTime: "~17:04", availableSeats: 88, totalSeats: 116)
                ]),
                .init(theaterName: "BTS관 (9층 2관) [Laser]", screenType: "2D", showtimes: [
                    .init(startTime: "11:30", endTime: "~13:58", availableSeats: 34, totalSeats: 116),
                    .init(startTime: "14:10", endTime: "~16:32", availableSeats: 100, totalSeats: 116),
                    .init(startTime: "16:50", endTime: "~19:00", availableSeats: 13, totalSeats: 116),
                    .init(startTime: "19:20", endTime: "~21:40", availableSeats: 92, totalSeats: 116)
                ])
            ])
        ]
    
    private var cancellables = Set<AnyCancellable>()
        
        init() {
            $selectedMovie
                .map { $0 != nil }
                .receive(on: RunLoop.main)
                .assign(to: \.isTheaterButtonEnabled, on: self)
                .store(in: &cancellables)
            
            $isTheaterButtonEnabled
                .dropFirst()
                .map { $0 }
                .assign(to: \.isDateButtonEnabled, on: self)
                .store(in: &cancellables)
            
            $selectedPlaces
                .map { !$0.isEmpty }
                .receive(on: RunLoop.main)
                .assign(to: \.isDateButtonEnabled, on: self)
                .store(in: &cancellables)
            
            Publishers.CombineLatest3($selectedMovie, $selectedPlaces, $selectedDate)
                        .map { movie, places, date in
                            return movie != nil && !places.isEmpty && date != nil
                        }
                        .receive(on: RunLoop.main)
                        .assign(to: \.isShowtimesVisible, on: self)
                        .store(in: &cancellables)
        }
}
