//
//  MovieAPI.swift
//  mega
//
//  Created by 이경민 on 11/10/25.
//

import Foundation
import Moya

enum MovieAPI {
    case nowPlaying(language: String = "ko-KR", page: Int = 1, region: String = "KR")
}

extension MovieAPI: TargetType {
    var baseURL: URL { URL(string: "https://api.themoviedb.org/3")! }

    var path: String {
        switch self {
        case .nowPlaying:
            return "/movie/now_playing"
        }
    }

    var method: Moya.Method {
        switch self {
        case .nowPlaying:
            return .get
        }
    }

    var task: Task {
        switch self {
        case let .nowPlaying(language, page, region):
            let params: [String: Any] = [
                "language": language,
                "page": page,
                "region": region
            ]
            // GET 쿼리스트링
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        [
            "Authorization": "Bearer \(TMDBKeys.bearer)",
            "Accept": "application/json"
        ]
    }

    var sampleData: Data {
        switch self {
        case .nowPlaying:
            let json = """
            {
              "dates": {"maximum": "2025-11-30", "minimum": "2025-10-10"},
              "page": 1,
              "results": [
                { "id": 123, "title": "샘플 영화", "original_title": "Sample",
                  "poster_path": "/abc.jpg", "release_date": "2025-11-01",
                  "vote_average": 7.2, "overview":"샘플 개요" }
              ],
              "total_pages": 10,
              "total_results": 200
            }
            """
            return Data(json.utf8)
        }
    }
}

