//
//  MovieDetailViewModel.swift
//  mega
//
//  Created by 이경민 on 11/11/25.
//

import Foundation
import Moya
import Observation

@MainActor
@Observable
final class MovieDetailViewModel {
    var isLoading = false
    var errorMessage: String?
    var detail: MovieDetailModel?

    private let provider: MoyaProvider<MovieAPI>

    init(provider: MoyaProvider<MovieAPI> = tmdbProvider) {
        self.provider = provider
    }

    func load(movieId: Int, language: String = "ko-KR", region: String? = "KR") async {
        isLoading = true; defer { isLoading = false }
        errorMessage = nil

        do {
            let req = MovieDetailRequest(language: language, region: region)
            let resp = try await provider.requestAsync(.detail(id: movieId, req))
            guard (200...299).contains(resp.statusCode) else {
                errorMessage = "HTTP \(resp.statusCode)"
                return
            }
            let decoded = try JSONDecoder().decode(MovieDetailResponse.self, from: resp.data)
            self.detail = decoded.toDomain()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
