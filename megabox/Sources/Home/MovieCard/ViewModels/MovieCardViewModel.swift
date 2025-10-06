import SwiftUI

@Observable
class MovieCardViewModel {
    var movies: [MovieCard] = [
        MovieCard(title: "어쩔수가없다", audience: "누적관객수 20만", imageName: "poster_noway"),
        MovieCard(title: "극장판 귀멸의 칼날", audience: "누적관객수 127만", imageName: "poster_demonslayer"),
        MovieCard(title: "F1 더 무비", audience: "누적관객수 3만", imageName: "poster_f1"),
        MovieCard(title: "얼굴", audience: "누적관객수 100만", imageName: "poster_face"),
        MovieCard(title: "모노노케 히메", audience: "누적관객수 10만", imageName: "poster_princess")
    ]
}
