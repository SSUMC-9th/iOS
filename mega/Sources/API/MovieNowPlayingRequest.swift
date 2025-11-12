//
//  MovieNowPlayingRequest.swift
//  mega
//
//  Created by 이경민 on 11/11/25.
//

import Foundation

struct MovieNowPlayingRequest: Encodable {
    var language: String
    var page: Int
    var region: String?

    init(language: String = "ko-KR", page: Int = 1, region: String? = "KR") {
        self.language = language
        self.page = page
        self.region = region
    }

    func asParameters() -> [String: Any] {
        var p: [String: Any] = [
            "language": language,
            "page": page
        ]
        if let region { p["region"] = region }
        return p
    }
}

