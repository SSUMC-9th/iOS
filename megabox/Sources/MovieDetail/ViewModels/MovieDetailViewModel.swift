import SwiftUI

@Observable
class MovieDetailViewModel {
    private(set) var details: [MovieDetail] = [
        MovieDetail(
            title: "어쩔수가없다",
            englishTitle: "No Choice",
            description: "평범한 일상 속, 뜻밖의 선택으로 벌어지는 이야기.",
            releaseDate: "2025.06.20 개봉",
            ageRating: "12세 이상 관람가",
            detailImage: "poster_detail_f1"
        ),
        MovieDetail(
            title: "극장판 귀멸의 칼날",
            englishTitle: "Demon Slayer: Mugen Train",
            description: "탄지로와 동료들의 열차 안 사투!",
            releaseDate: "2025.07.10 개봉",
            ageRating: "15세 이상 관람가",
            detailImage: "poster_detail_f1"
        ),
        MovieDetail(
            title: "F1 더 무비",
            englishTitle: "F1: The Movie",
            description: "최고가 되지 못한 전설 VS 최고가 되고 싶은 루키\n\n한때 주목받는 유망주였지만 끔찍한 사고로 F1에서 우승하지 못하고 한순간에 추락한 드라이버 '손; 헤이스'(브래드 피트).\n그의 오랜 동료인 '루벤 세르반테스'(하비에르 바르뎀)에게 레이싱 복귀를 제안받으며 최하위 팀인 APGXP에 합류한다.",
            releaseDate: "2025.06.25 개봉",
            ageRating: "12세 이상 관람가",
            detailImage: "poster_detail_f1"
        )
    ]
    
    func getDetail(for card: MovieCard) -> MovieDetail? {
        return details.first(where: { $0.title == card.title })
    }
}
