//
//  ReservView.swift
//  mega
//
//  Created by 이경민 on 10/5/25.
//
import SwiftUI

struct ReservView: View {
    @StateObject private var viewModel = ReservViewModel()
    @State private var isShowingMovieSearch = false

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                Color("purple04").frame(height: 120)
                Color.white
            }.ignoresSafeArea()

            if viewModel.isLoading {
                ProgressView("영화 정보를 불러오는 중...")
                    .font(.bold18)
                    .foregroundStyle(Color("gray04"))
            } else if let error = viewModel.errorMessage {
                Text("에러: \(error)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                ScrollView {
                    VStack(spacing: 0) {
                        Spacer().frame(height: 56)
                        movieNameSection
                            .padding(.horizontal, 16)
                            .padding(.bottom, 20)
                        moviePoster
                            .padding(.horizontal, 16)
                            .padding(.bottom, 32)
                        theaterPlaceSection
                            .padding(.horizontal, 16)
                            .padding(.bottom, 29)
                        dateSelectionSection
                            .padding(.horizontal, 16)
                            .padding(.bottom, 49)
                        showtimesSection
                            .padding(.horizontal, 16)
                    }
                }
                .background(Color.white)
                topHeader
            }
        }
    }

    private var topHeader: some View {
        HStack {
            Text("영화별 예매")
                .font(.headline)
                .foregroundStyle(Color.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 10)
        .background(Color("purple04"))
    }

    // MARK: - 영화 이름 섹션
    private var movieNameSection: some View {
        HStack(spacing: 0) {
            if let selectedMovie = viewModel.selectedMovie {
                let jsonMovie = viewModel.movieScheduleData?.movies.first {
                    $0.title == selectedMovie.movieName
                }

                Text(jsonMovie?.ageRating ?? "")
                    .font(.bold18)
                    .foregroundStyle(Color.white)
                    .frame(width: 26, height: 24)
                    .background(Color(hex: "FF8000"))
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .padding(.trailing, 17)

                Text(selectedMovie.movieName)
                    .font(.PretendardSemiBold18)
                    .frame(width: 238, alignment: .leading)
            } else {
                Text("영화 선택")
                    .font(.PretendardSemiBold18)
            }

            Spacer()
        }
    }


    // MARK: - 영화 포스터 섹션
    // ReservView.swift 내부의 moviePoster 수정
    private var moviePoster: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 8) {
                ForEach(Array(viewModel.movieViewModel.enumerated()), id: \.offset) { index, movie in
                    ReservMovieCard(
                        movieInfo: movie,
                        isSelected: viewModel.selectedMovieIndex == index
                    )
                    .onTapGesture {
                        if viewModel.selectedMovieIndex != index {
                            viewModel.selectedMovieIndex = index
                            viewModel.selectedPlaces.removeAll()
                            viewModel.selectedDate = nil
                        }
                        viewModel.selectedMovie = movie
                    }
                }
            }
        }
        .frame(height: 89)
        .scrollIndicators(.hidden)
    }


    // MARK: - 지역 선택 섹션
    private var theaterPlaceSection: some View {
        HStack(spacing: 8) {
            ForEach(["강남", "홍대", "신촌"], id: \.self) { place in
                Button {
                    if viewModel.selectedPlaces.contains(place) {
                        viewModel.selectedPlaces.remove(place)
                    } else {
                        viewModel.selectedPlaces.insert(place)
                    }
                } label: {
                    Text(place)
                        .font(.semiBold16)
                        .foregroundStyle(
                            viewModel.selectedPlaces.contains(place)
                            ? .white
                            : (viewModel.isTheaterButtonEnabled ? Color("gray05") : .gray.opacity(0.4))
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
            }
            Spacer()
        }
    }

    // MARK: - 날짜 선택
    private var dateSelectionSection: some View {
        HStack(spacing: 5) {
            ForEach(Array(viewModel.dates.enumerated()), id: \.offset) { index, date in
                let isSelected = viewModel.selectedDate?.isSameDay(as: date) ?? false
                let fgDay: Color = isSelected ? .white : .black
                let fgWeek: Color = isSelected ? .white : Color("gray03")
                let bg: Color = isSelected ? Color("purple04") : .white

                VStack(spacing: 4) {
                    Text(date.dayOfMonth())
                        .font(.bold18)
                        .foregroundStyle(fgDay)

                    Text(date.weekdayString(for: index))
                        .font(.semiBold14)
                        .foregroundStyle(fgWeek)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(bg)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .onTapGesture { viewModel.selectedDate = date }
            }
        }
    }


    // MARK: - 상영 정보 섹션
    private var showtimesSection: some View {
        VStack(alignment: .leading, spacing: 29) {
            if viewModel.isShowtimesVisible {
                if viewModel.filteredSchedules.isEmpty {
                    Text("선택한 조건에 해당하는 상영 정보가 없습니다.")
                        .font(.bold18)
                        .foregroundStyle(Color("gray04"))
                        .frame(maxWidth: .infinity, minHeight: 150)
                } else {
                    ForEach(viewModel.filteredSchedules, id: \.name) { area in
                        LocationScheduleView(
                            locationSchedule: LocationSchedule(
                                locationName: area.name,
                                schedules: area.items.map {
                                    TheaterSchedule(
                                        theaterName: $0.auditorium,
                                        screenType: $0.format,
                                        showtimes: $0.showtimes.map {
                                            Showtime(
                                                startTime: $0.start,
                                                endTime: $0.end,
                                                availableSeats: $0.available,
                                                totalSeats: $0.total
                                            )
                                        }
                                    )
                                }
                            )
                        )
                    }
                }
            }
        }
    }
}


#Preview{
    ReservView()
}
