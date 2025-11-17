//
//  HomeViewModel.swift
//  mega
//
//  Created by 이경민 on 9/28/25.
//

import Foundation
import Moya
import Observation

@MainActor
@Observable
final class HomeViewModel {
    var isLoading = false
    var errorMessage: String?
    var cards: [MovieCardModel] = []
    var details: [Int: MovieDetailModel] = [:]

    private let provider: MoyaProvider<MovieAPI>

    init(provider: MoyaProvider<MovieAPI> = tmdbProvider) {
        self.provider = provider
    }

    func loadNowPlaying(language: String = "ko-KR", page: Int = 1, region: String = "KR") async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let req = MovieNowPlayingRequest(language: language, page: page, region: region)
            let response = try await provider.requestAsync(.nowPlaying(req))
            let decoded = try JSONDecoder().decode(MovieNowPlayingResponse.self, from: response.data)

            let fixedAudience = 1_234_567
            let fixedAge = 12

            // results → 카드 모델 매핑
            let mappedCards: [MovieCardModel] = decoded.results.map { item in
                MovieCardModel(
                    id: item.id,
                    title: item.title,
                    posterURL: TMDBImage.posterURL(path: item.posterPath),
                    cumulativeAudience: fixedAudience
                )
            }

            // results → 상세 모델 매핑
            var mappedDetails: [Int: MovieDetailModel] = [:]
            decoded.results.forEach { item in
                let detail = MovieDetailModel(
                    id: item.id,
                    title: item.title,
                    overview: item.overview ?? "",
                    releaseDate: item.releaseDate,
                    voteAverage: item.voteAverage,
                    ageRating: fixedAge,
                    backdropURL: TMDBImage.backdropURL(path: item.backdropPath)
                )
                mappedDetails[item.id] = detail
            }

            self.cards = mappedCards
            self.details = mappedDetails

        } catch {
            self.errorMessage = (error as? MoyaError)?.errorDescription ?? error.localizedDescription
            print("[NowPlaying] error:", error)
        }
    }
}

