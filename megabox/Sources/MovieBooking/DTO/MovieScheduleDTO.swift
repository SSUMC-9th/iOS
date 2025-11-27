import Foundation

struct MovieScheduleResponseDTO: Decodable {
    let status: String
    let message: String
    let data: MovieScheduleDataDTO
}

struct MovieScheduleDataDTO: Decodable {
    let movies: [MovieDTO]
}

struct MovieDTO: Decodable {
    let id: String
    let title: String
    let ageRating: String
    let schedules: [ScheduleDTO]

    enum CodingKeys: String, CodingKey {
        case id, title
        case ageRating = "age_rating"
        case schedules
    }
}

struct ScheduleDTO: Decodable {
    let date: String
    let areas: [AreaDTO]
}

struct AreaDTO: Decodable {
    let area: String
    let items: [ItemDTO]
}

struct ItemDTO: Decodable {
    let auditorium: String
    let format: String
    let showtimes: [ShowtimeDTO]
}

struct ShowtimeDTO: Decodable {
    let start: String
    let end: String
    let available: Int
    let total: Int
}

extension MovieDTO {
    func toTheaterShowtimes(for date: Date, theaters selectedTheaters: [String]) -> [TheaterShowtimes] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)

        // 선택한 날짜의 일정만 찾기
        guard let schedule = schedules.first(where: { $0.date == dateString }) else { return [] }

        // 선택된 지역(극장)만 필터링
        let filteredAreas = schedule.areas.filter { selectedTheaters.contains($0.area) }

        return filteredAreas.map { area in
            TheaterShowtimes(
                branch: area.area,
                rooms: area.items.map { item in
                    RoomShowtimes(
                        name: item.auditorium,
                        format: item.format,
                        times: item.showtimes.map { show in
                            Showtime(start: show.start, end: show.end, reserved: show.total - show.available, total: show.total)
                        }
                    )
                }
            )
        }
    }
}
