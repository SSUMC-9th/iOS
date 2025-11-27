import SwiftUI
import Combine

final class MovieBookingViewModel: ObservableObject {
    @Published var movies: [MovieBooking] = []
    @Published var theaters: [String] = ["강남", "홍대", "신촌", ]
    @Published var selectedMovie: MovieBooking? = nil
    @Published var selectedTheaters: [String] = []
    @Published var selectedDate: Date? = nil
    @Published var availableDates: [Date] = []
    var canShowDates: Bool { selectedMovie != nil && !selectedTheaters.isEmpty }
    @Published var showtimeGroups: [TheaterShowtimes] = []
    
    @Published var canSelectTheater: Bool = false
    var canShowTimes: Bool { canShowDates && selectedDate != nil }
    
    private let calendar = Calendar.current
    private let weekdaySymbolsKOR = ["일", "월", "화", "수", "목", "금", "토"]
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        movies = [
            MovieBooking(title: "F1 더 무비", imageName: "poster_f1", ageRating: 12),
            MovieBooking(title: "귀멸의 칼날: 무한성", imageName: "poster_demonslayer", ageRating: 15),
            MovieBooking(title: "어쩔수가없다", imageName: "poster_noway", ageRating: 15),
            MovieBooking(title: "얼굴", imageName: "poster_face", ageRating: 15),
            MovieBooking(title: "모노노케 히메", imageName: "poster_princess", ageRating: 15),
            MovieBooking(title: "보스", imageName: "poster_boss", ageRating: nil),
            MovieBooking(title: "The roses", imageName: "poster_theroses", ageRating: 19),
        ]
        $selectedMovie
            .map { $0 != nil } // 영화가 있으면 true, 없으면 false
            .assign(to: &$canSelectTheater) // 자동으로 canSelectTheater 업데이트
        
        regenerateWeek()
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
    
    
    func regenerateWeek(startingFrom date: Date = Date()) {
        let start = calendar.startOfDay(for: date)
        availableDates = (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: start) }
        // 선택 초기화(옵션)
        if let sel = selectedDate, !availableDates.contains(where: { calendar.isDate($0, inSameDayAs: sel) }) {
            selectedDate = nil
        }
    }
    
    // 셀 라벨들
    func weekday(_ date: Date) -> String {
        let w = calendar.component(.weekday, from: date) // 1=일
        return weekdaySymbolsKOR[w-1]
    }
    func day(_ date: Date) -> String {
        let d = calendar.component(.day, from: date)
        return String(d)
    }
    func isToday(_ date: Date) -> Bool { calendar.isDateInToday(date) }
    func isSameDay(_ a: Date?, _ b: Date) -> Bool {
        guard let a else { return false }
        return calendar.isDate(a, inSameDayAs: b)
    }
    
    // "오늘/내일/요일" 캡션
    func dayCaption(_ date: Date) -> String {
        if calendar.isDateInToday(date) { return "오늘" }
        if let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date()),
           calendar.isDate(date, inSameDayAs: tomorrow) { return "내일" }
        return weekday(date) // "일"~"토"
    }
    
    // 주말 판별
    func weekendColor(for date: Date, selected: Bool) -> Color {
        if selected { return .white } // 선택 시는 전부 흰색
        let w = calendar.component(.weekday, from: date) // 1=일, 7=토
        if w == 1 { return .red }      // 일
        if w == 7 { return .teal }     // 토 (시스템 컬러)
        return .black                  // 평일
    }
    
    func fetchShowtimes(for movie: MovieBooking, theaters: [String], date: Date) async {
//        isLoading = true
//        defer { isLoading = false } // 끝나면 자동으로 false

        // 1️⃣ 번들에서 JSON 파일 읽기
        guard let url = Bundle.main.url(forResource: "MovieSchedule", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("파일을 찾을 수 없습니다.")
            showtimeGroups = []
            return
        }

        do {

            // JSON 디코딩 (DTO 구조 사용)
            let decoded = try JSONDecoder().decode(MovieScheduleResponseDTO.self, from: data)
            print("JSON decode 성공. 영화 개수:", decoded.data.movies.count)

            // 해당 영화 데이터 찾기
            guard let movieDTO = decoded.data.movies.first(where: { $0.title == movie.title }) else {
                print("해당 영화 데이터 없음: \(movie.title)")
                showtimeGroups = []
                return
            }

            // DTO → Domain 매핑
            let mapped = movieDTO.toTheaterShowtimes(for: date, theaters: theaters)
            print("변환된 상영 데이터 개수:", mapped.count)
            // View 반영
            showtimeGroups = mapped

        } catch {
            print("디코딩 에러:", error)
            showtimeGroups = []
        }
    }

    
    
}
