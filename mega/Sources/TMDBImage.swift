//
//  TMDBImage.swift
//  mega
//
//  Created by 이경민 on 11/11/25.
//

import Foundation

enum TMDBImage {
    static func posterURL(path: String?, size: String = "w500") -> URL? {
        guard let p = path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/\(size)\(p)")
    }

    static func backdropURL(path: String?, size: String = "w780") -> URL? {
        guard let p = path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/\(size)\(p)")
    }
}
