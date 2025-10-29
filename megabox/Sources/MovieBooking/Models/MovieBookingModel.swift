import Foundation

struct MovieBooking: Identifiable {
    let id = UUID()
    let title: String          // MovieCard.title과 매칭
    let imageName: String
    let ageRating: Int?
}
