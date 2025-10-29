import Foundation

struct MovieDetail: Identifiable {
    let id = UUID()
    let title: String          // MovieCard.title과 매칭
    let englishTitle: String
    let description: String
    let releaseDate: String
    let ageRating: String
    let detailImage : String
}
