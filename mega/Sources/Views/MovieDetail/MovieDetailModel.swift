//
//  MovieDetailModel.swift
//  mega
//
//  Created by 이경민 on 9/30/25.
//

import Foundation

struct MovieCardModel: Identifiable {
    let id: Int
    let title: String
    let posterURL: URL?
    let cumulativeAudience: Int
}

struct MovieDetailModel: Identifiable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String?
    let voteAverage: Double
    let ageRating: Int
    let backdropURL: URL?
}
