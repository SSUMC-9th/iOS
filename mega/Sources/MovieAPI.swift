//
//  MovieAPI.swift
//  mega
//
//  Created by 이경민 on 11/10/25.
//

import Foundation
import Moya

enum MovieAPI{
    case nowPlaying(language: String = "ko-KR", page: Int = 1, region: String = "KR")
}
