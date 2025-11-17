//
//  MovieAPI.swift
//  mega
//
//  Created by 이경민 on 11/10/25.
//

import Foundation
import Moya

enum MovieAPI {
    case nowPlaying(MovieNowPlayingRequest)
    case detail(id: Int, MovieDetailRequest)
}

struct MovieDetailRequest: Encodable {
    let language: String
    let region: String?

    init(language: String = "ko-KR", region: String? = "KR") {
        self.language = language
        self.region = region
    }

    func asParameters() -> [String: Any] {
        var p: [String: Any] = ["language": language]
        if let region { p["region"] = region }
        return p
    }
}

extension MovieAPI: TargetType {
    var baseURL: URL { URL(string: "https://api.themoviedb.org/3")! }
    
    var path: String {
        switch self {
        case .nowPlaying:
            return "/movie/now_playing"
            
        case .detail(let id, _):
            return "/movie/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .nowPlaying, .detail:
        return .get
        }
    }
    
    var task: Task {
        switch self {
        case .nowPlaying(let req):
            return .requestParameters(
                parameters: req.asParameters(),
                encoding: URLEncoding.queryString
            )
            
        case .detail(_, let req):
            return .requestParameters(parameters: req.asParameters(),
                                      encoding: URLEncoding.queryString)
        }
    }
    
    
    var headers: [String : String]? {
        guard TMDBKeys.bearer.isEmpty == false else { return ["Accept":"application/json"] }
        return [
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
            
        case .detail:
                    let json = """
                    {
                      "id": 123,
                      "title": "샘플 영화",
                      "original_title": "Sample",
                      "overview": "상세 응답 샘플",
                      "release_date": "2025-11-01",
                      "backdrop_path": "/backdrop.jpg",
                      "poster_path": "/abc.jpg",
                      "vote_average": 7.2
                    }
                    """
                    return Data(json.utf8)
        }
    }
}

