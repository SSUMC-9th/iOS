import Foundation

struct MovieCard: Identifiable {
    let id = UUID()
    let title: String
    let audience: String
    let imageName: String
}
