import Foundation

struct MovieBooking: Identifiable {
    let id = UUID()
    let title: String          // MovieCard.title과 매칭
    let imageName: String
    let ageRating: Int?
}

struct Showtime: Identifiable, Hashable {
    let id = UUID()
    let start: String
    let end: String
    let reserved: Int
    let total: Int
}

struct RoomShowtimes: Identifiable, Hashable {
    let id = UUID()
    let name: String        // 예: "리클라이너 1관", "BTS관 (7층 1관 [Laser])"
    let format: String?     // 예: "2D", "3D", "4DX" 등 (필요 없으면 nil)
    let times: [Showtime]
}

struct TheaterShowtimes: Identifiable, Hashable {
    let id = UUID()
    let branch: String      // 예: "강남", "홍대"
    let rooms: [RoomShowtimes]
}
