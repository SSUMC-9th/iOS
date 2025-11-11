//
//  MovieDetailResponse.swift
//  mega
//
//  Created by 이경민 on 11/11/25.
//

import Foundation

struct MovieDetailResponse: Decodable {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String?
    let releaseDate: String?
    let backdropPath: String?
    let posterPath: String?
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case originalTitle = "original_title"
        case releaseDate   = "release_date"
        case backdropPath  = "backdrop_path"
        case posterPath    = "poster_path"
        case voteAverage   = "vote_average"
    }
}

extension MovieDetailResponse {
    func toDomain() -> MovieDetailModel {
        MovieDetailModel(
            id: id,
            title: title,
            overview: overview ?? "",
            releaseDate: releaseDate,
            voteAverage: voteAverage,
            ageRating: 12,
            backdropURL: TMDBImage.backdropURL(path: backdropPath)
        )
    }
}
