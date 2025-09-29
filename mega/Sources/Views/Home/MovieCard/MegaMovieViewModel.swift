//
//  MegaMovieViewModel.swift
//  mega
//
//  Created by 이경민 on 9/29/25.
//

import Foundation
import SwiftUI

@Observable
class MegaMovieViewModel{
    var currentIndex:Int=0
    
    let movieViewModel:[MegaMovieModel] = [
            .init(movieImage:.init(.ajjulsu), movieName:"어쩔수가없다", movieReserCount: "누적관객수 20만"),
            .init(movieImage:.init(.knife), movieName:"귀멸의 칼날", movieReserCount: "누적관객수 1만"),
            .init(movieImage:.init(.f1), movieName:"F1 더 무비", movieReserCount: "누적관객수 5만"),
            .init(movieImage:.init(.face), movieName:"얼굴", movieReserCount: "누적관객수 10만"),
            .init(movieImage:.init(.monono), movieName:"모노노케 히메", movieReserCount: "누적관객수 12만")
        ]
}
