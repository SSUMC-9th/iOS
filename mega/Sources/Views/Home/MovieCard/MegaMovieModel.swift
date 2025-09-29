//
//  MovieModel.swift
//  mega
//
//  Created by 이경민 on 9/29/25.
//

import SwiftUI
import Foundation

struct MegaMovieModel:Identifiable{
    let id: UUID = UUID() 
    let movieImage: Image
    let movieName: String
    let movieReserCount: String
}

