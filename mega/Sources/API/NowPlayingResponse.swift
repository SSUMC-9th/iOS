//
//  NowPlayingResponse.swift
//  mega
//
//  Created by 이경민 on 11/10/25.
//

import Foundation

struct NowPlayingResponse: Decodable {
    struct Dates: Decodable { let maximum: String?; let minimum: String? }
    struct Movie: Decodable {
        let id: Int
        let title: String
        let original_title: String?
        let poster_path: String?
        let release_date: String?
        let vote_average: Double?
        let overview: String?
    }
    let dates: Dates?
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}

