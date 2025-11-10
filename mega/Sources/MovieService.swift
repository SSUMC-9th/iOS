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
                         completion: @escaping (Result<NowPlayingResponse, Error>) -> Void) {
        // 안전 체크: 키 누락
        guard TMDBKeys.bearer.isEmpty == false else {
            completion(.failure(MovieServiceError.emptyKey)); return
        }

        tmdbProvider.request(.nowPlaying(language: language, page: page, region: region)) { result in
            switch result {
            case .failure(let err):
                completion(.failure(err))
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(NowPlayingResponse.self, from: response.data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(MovieServiceError.decoding))
                }
            }
        }
    }
}

