//
//  TMDBProvider.swift
//  mega
//
//  Created by 이경민 on 11/10/25.
//

import Foundation
import Moya

let tmdbProvider = MoyaProvider<MovieAPI>(
    plugins: [
        NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
    ]
)
