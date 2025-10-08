import SwiftUI
import Combine

final class MovieBookingViewModel: ObservableObject {
    @Published var movies: [MovieBooking] = []
    @Published var theaters: [String] = ["강남", "홍대", "신촌", ]
    @Published var selectedMovie: MovieBooking? = nil
    @Published var selectedTheaters: [String] = []
    @Published var selectedDate: Date? = nil
    @Published var canSelectTheater: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        movies = [
            MovieBooking(title: "F1 더 무비", imageName: "poster_f1", ageRating: 12),
            MovieBooking(title: "극장판 귀멸의 칼날", imageName: "poster_demonslayer", ageRating: 15),
            MovieBooking(title: "어쩔수가없다", imageName: "poster_noway", ageRating: 15),
            MovieBooking(title: "얼굴", imageName: "poster_face", ageRating: 15),
            MovieBooking(title: "모노노케 히메", imageName: "poster_princess", ageRating: 15),
            MovieBooking(title: "보스", imageName: "poster_boss", ageRating: nil),
            MovieBooking(title: "The roses", imageName: "poster_theroses", ageRating: 19),
        ]
        $selectedMovie
            .map { $0 != nil } // 영화가 있으면 true, 없으면 false
            .assign(to: &$canSelectTheater) // 자동으로 canSelectTheater 업데이트
    }

    func selectMovie(_ movie: MovieBooking) {
        selectedMovie = movie
        selectedTheaters = []  // 영화 변경 시 극장 초기화
        selectedDate = nil     // 날짜도 초기화
    }
    
    func toggleTheater(_ theater: String) {
        if selectedTheaters.contains(theater) {
            selectedTheaters.removeAll { $0 == theater } // 선택 해제
        } else {
            selectedTheaters.append(theater) // 선택 추가
        }
    }
    
    // 나이제한 표시 텍스트 반환 함수
    func getAgeRatingText(for movie: MovieBooking?) -> String {
        guard let age = movie?.ageRating else {
            return "ALL"
        }
        return "\(age)"
    }

    func getAgeRatingColor(for movie: MovieBooking?) -> Color {
        guard let age = movie?.ageRating else { return .green }
        
        switch age {
        case 19: return .red
        case 15: return .orange
        case 12: return .yellow
        default: return .gray
        }
    }

}
