//
//  ReservViewModel.swift
//  mega
//
//  Created by 이경민 on 10/5/25.
//

//
//  ReservViewModel.swift
//  mega
//
//  Created by 이경민 on 10/27/25.
//

import SwiftUI
import Combine
import Foundation

@MainActor
final class ReservViewModel: ObservableObject {
    @Published var selectedMovie: ReservModel? = nil
    // MARK: - Published Properties
    @Published var selectedMovieIndex: Int? = nil
    @Published var selectedPlaces: Set<String> = []
    @Published var selectedDate: Date? = nil
    
    @Published var isTheaterButtonEnabled: Bool = false
    @Published var isDateButtonEnabled: Bool = false
    @Published var isShowtimesVisible: Bool = false
    
    @Published var movieScheduleData: MovieSchedule? = nil
    @Published var filteredSchedules: [AreaDomain] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
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
    
    
    // MARK: - Date range (1 week)
//    let dates: [Date] = (0..<7).compactMap {
//        Calendar.current.date(byAdding: .day, value: $0, to: Date())
//    }
    let dates: [Date] = [
        DateFormatter.apiDateFormatter.date(from: "2025-09-22")!,
        DateFormatter.apiDateFormatter.date(from: "2025-09-23")!,
        DateFormatter.apiDateFormatter.date(from: "2025-09-24")!,
        DateFormatter.apiDateFormatter.date(from: "2025-09-25")!,
        DateFormatter.apiDateFormatter.date(from: "2025-09-26")!,
        DateFormatter.apiDateFormatter.date(from: "2025-09-27")!,
        DateFormatter.apiDateFormatter.date(from: "2025-09-28")!,
    ]
    
    // MARK: - Init
    init() {
        setupBindings()
        loadMovieSchedules()
    }
    
    // MARK: - Load JSON asynchronously
    func loadMovieSchedules() {
        Task {
            await fetchMovieSchedules()
        }
    }
    
    private func fetchMovieSchedules() async {
        isLoading = true
        errorMessage = nil
        
        print("Bundle Path:", Bundle.main.bundlePath)
        print("Resource URL:", Bundle.main.url(forResource: "MovieSchedule", withExtension: "json") as Any)

        do {
            guard let url = Bundle.main.url(forResource: "MovieSchedule", withExtension: "json") else {
                throw NSError(domain: "FileError", code: 404, userInfo: [NSLocalizedDescriptionKey: "MovieSchedule.json 파일을 찾을 수 없습니다."])
            }
            
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let dto = try decoder.decode(MovieScheduleResponse.self, from: data)
            let domainModel = dto.toDomain()
            
            self.movieScheduleData = domainModel
            self.isLoading = false
        } catch {
            self.isLoading = false
            self.errorMessage = error.localizedDescription
            print("JSON 로드 실패:", error)
        }
    }
    
    // MARK: - Bindings
    private func setupBindings() {
        Publishers.CombineLatest3($selectedMovieIndex, $selectedPlaces, $selectedDate)
            .sink { [weak self] movieIndex, places, date in
                guard let self = self else { return }
                self.updateFilteredSchedules(movieIndex: movieIndex, places: places, date: date)
                self.isShowtimesVisible = (movieIndex != nil && !places.isEmpty && date != nil)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Filtering Logic
    private func updateFilteredSchedules(movieIndex: Int?, places: Set<String>, date: Date?) {
        guard
            let selectedMovie = selectedMovie,
            let date = date
        else {
            filteredSchedules = []
            return
        }

        // 이름으로 JSON 영화 찾기 (index 대신 title 매칭)
        guard let movie = movieScheduleData?.movies.first(where: {
            $0.title == selectedMovie.movieName
        }) else {
            filteredSchedules = []
            print("해당 영화 이름을 JSON에서 찾지 못함: \(selectedMovie.movieName)")
            return
        }

        // 날짜 문자열 변환
        let selectedDateString = DateFormatter.apiDateFormatter.string(from: date)

        // 해당 날짜의 스케줄 찾기
        guard let targetSchedule = movie.schedules.first(where: {
            DateFormatter.apiDateFormatter.string(from: $0.date ?? Date()) == selectedDateString
        }) else {
            filteredSchedules = []
            print("날짜 \(selectedDateString)에 대한 스케줄이 없음")
            return
        }

        // 지역 필터링
        if places.isEmpty {
            filteredSchedules = targetSchedule.areas
        } else {
            filteredSchedules = targetSchedule.areas.filter { places.contains($0.name) }
        }

        print("필터링 성공: \(movie.title), 날짜: \(selectedDateString), 지역: \(places)")
    }

}

// MARK: - Collection Safe Index
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
