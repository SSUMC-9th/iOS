//
//  ReservView.swift
//  mega
//
//  Created by 이경민 on 10/5/25.
//

import Foundation
import SwiftUI

struct ReservView: View {
    @StateObject private var viewModel = ReservViewModel()
    @State private var isShowingMovieSearch = false
    
    var body : some View {
        ZStack(alignment: .top){
            VStack(spacing: 0) {
                Color("purple04")
                    .frame(height: 120)             // 상단 헤더 영역을 채울 보라색
                Color.white                        // 나머지 영역 채우는 색
            }.ignoresSafeArea()
            
            ScrollView{
                VStack(spacing: 0){
                    Spacer()
                        .frame(height: 56)
//                    topHeader
//                        .padding(.bottom, 12)
                    movieName
                        .padding(.horizontal, 16)
                        .padding(.bottom, 20)
                    moviePoster
                        .padding(.horizontal, 16)
                        .padding(.bottom, 32)
                    theaterPlace
                        .padding(.horizontal, 16)
                        .padding(.bottom, 29)
                    dateSelection
                        .padding(.horizontal, 16)
                        .padding(.bottom, 49)
                    showtimesView
                        .padding(.horizontal, 16)
                    Spacer()
                    
                }
            }
            .background(Color.white)
            topHeader
        }
    }
    
    private var topHeader: some View{
        HStack{
            Text("영화별 예매")
                .font(.headline)
                .foregroundStyle(Color.white)
                .frame(height:30)
        }.frame(maxWidth:.infinity)
        .padding(.bottom, 10)
        .background(Color("purple04"))
    }
    
    private var movieName: some View{
        HStack(spacing:0){
            Text("15")
                .font(.bold18)
                .foregroundStyle(Color.white)
                .frame(width:26, height:24)
                .background(Color(hex: "FF8000"))
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .padding(.trailing, 37)
            
            Text(viewModel.selectedMovie?.movieName ?? "영화 선택")
                .font(.PretendardSemiBold18)
                .frame(width: 238, height: 24, alignment: .leading)
            
            Button(action:{
                self.isShowingMovieSearch = true
            }){
                Text("전체영화")
                    .font(.semiBold14)
                    .foregroundStyle(Color.black)
                    .frame(width:69, height:30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("gray02"), lineWidth: 1)
                )
            }
        }.frame(maxWidth: .infinity)
        .sheet(isPresented: $isShowingMovieSearch) {
            MovieSearchView(selectedMovie: $viewModel.selectedMovie)
                .presentationDragIndicator(.visible)
        }
    }
    
    private var moviePoster: some View{
        ScrollView(.horizontal){
            LazyHStack(spacing:8){
                ForEach(viewModel.movieViewModel) { movie in
                    ReservMovieCard(
                        movieInfo: movie,
                        isSelected: viewModel.selectedMovie?.id == movie.id
                    ).onTapGesture {
                        if viewModel.selectedMovie?.id != movie.id {
                                viewModel.selectedPlaces.removeAll()
                                viewModel.selectedDate = nil
                        }
                        viewModel.selectedMovie = movie
                    }
                }
            }
        }.frame(height:89)
            .scrollIndicators(.hidden)
    }
    
    private var theaterPlace: some View{
        HStack(spacing:8){
            ForEach(["강남", "홍대", "신촌"], id: \.self) { place in
                Button(action: {
                    if viewModel.selectedPlaces.contains(place) {
                            viewModel.selectedPlaces.remove(place)
                        } else {
                            viewModel.selectedPlaces.insert(place)
                        }
                }) {
                    Text(place)
                        .font(.semiBold16)
                        .foregroundStyle(
                            viewModel.selectedPlaces.contains(place) ? Color.white : (viewModel.isTheaterButtonEnabled ? Color("gray05") : Color.gray.opacity(0.4))
                            )
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(
                            viewModel.selectedPlaces.contains(place)
                                ? Color("purple04")
                                : Color("gray01")
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .disabled(!viewModel.isTheaterButtonEnabled)
            }
            Spacer()
        }.frame(maxWidth:.infinity, minHeight:35)
    }
    
    private var dateSelection: some View {
            HStack(spacing: 5) {
                ForEach(Array(viewModel.dates.enumerated()), id: \.element) { index, date in
                    VStack(spacing: 4) {
                        Text(date.dayOfMonth())
                            .font(.bold18)
                            .foregroundStyle(
                                viewModel.selectedDate?.isSameDay(as: date) ?? false
                                ? .white
                                : (viewModel.isDateButtonEnabled ? .black : Color.gray.opacity(0.4))
                            )
                        
                        Text(date.weekdayString(for: index))
                            .font(.semiBold14)
                            .foregroundStyle(
                                viewModel.selectedDate?.isSameDay(as: date) ?? false
                                ? .white
                                : (viewModel.isDateButtonEnabled ? Color("gray03") : Color.gray.opacity(0.4))
                            )
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(
                        viewModel.selectedDate?.isSameDay(as: date) ?? false
                        ? Color("purple04")
                        : Color.white
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .onTapGesture {
                        if viewModel.isDateButtonEnabled {
                            viewModel.selectedDate = date
                        }
                    }
                }
            }
            .disabled(!viewModel.isDateButtonEnabled)
        }

    private var showtimesView: some View {
        VStack(alignment: .leading, spacing: 29) {
            if viewModel.isShowtimesVisible {
                if !(viewModel.selectedDate?.isSameDay(as: viewModel.dates.first ?? Date()) ?? false) {
                    NoShowtimesView()
                } else {
                    let placesInOrder = ["강남", "홍대", "신촌"].filter {
                        viewModel.selectedPlaces.contains($0)
                    }
                    
                    if placesInOrder.count == 1 && placesInOrder.first == "신촌" {
                        NoShowtimesView()
                    } else {
                        ForEach(placesInOrder, id: \.self) { place in
                            if let scheduleData = viewModel.allSchedules.first(where: { $0.locationName == place }) {
                                LocationScheduleView(locationSchedule: scheduleData)
                            } else {
                                // 데이터가 없는 경우
                            }
                        }
                    }
                }
            }
        }
    }

    private struct NoShowtimesView: View {
        var body: some View {
            Text("선택한 극장에 상용시간표가 없습니다")
                .font(.bold18)
                .foregroundStyle(Color("gray04"))
                .frame(maxWidth: .infinity, minHeight: 150)
        }
    }
}

extension Date {
    func dayOfMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }
    
    func weekdayString(for index: Int) -> String {
        if index == 0 {
            return "오늘"
        }else if(index == 1){
            return "내일"
        }
        else {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.dateFormat = "E"
            return formatter.string(from: self)
        }
    }
    
    func isSameDay(as otherDate: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: otherDate)
    }
}


#Preview{
    ReservView()
}
