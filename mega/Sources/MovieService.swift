//
//  MovieService.swift
//  mega
//
//  Created by 이경민 on 11/10/25.
//

import Foundation
import Moya

enum MovieServiceError: Error { case emptyKey, decoding }

final class MovieService {
    func fetchNowPlaying(language: String = "ko-KR",
                         page: Int = 1,
                         region: String = "KR",
                         completion: @escaping (Result<MovieNowPlayingResponse, Error>) -> Void) {

        guard TMDBKeys.bearer.isEmpty == false else {
            completion(.failure(MovieServiceError.emptyKey))
            return
        }

        let req = MovieNowPlayingRequest(language: language, page: page, region: region)

        tmdbProvider.request(.nowPlaying(req)) { result in
            switch result {
            case .failure(let err):
                completion(.failure(err))

            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(MovieNowPlayingResponse.self,
                                                           from: response.data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(MovieServiceError.decoding))
                }
            }
        }
    }
}
