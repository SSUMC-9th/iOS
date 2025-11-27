//
//  MovieDeatailView.swift
//  megabox
//
//  Created by 문인성 on 10/9/25.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(movie.imageName2)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)

                Text("F1 더 무비")
                Text("F1: The Movie")
                Text("""
                     최고가 되지 못한 전설 VS 최고가 되고 싶은 루키
                     한때 주목받는 유망주였지만 끔찍한 사고로 F1에서  우승하지 못하고
                     한순간에 추락한 드라이버 ‘손; 헤이스'(브래드 피트).
                     그의 오랜 동료인 ‘루벤 세르반테스'(하비에르 바르뎀)에게
                     레이싱 복귀를 제안받으며 최하위 팀인 APGXP에 합류한다.
                    """)
                Spacer()
            }
    
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
        let sampleMovie = Movie(
            title: "F1 더 무비",
            moviegoer: "누적관객수 10만",
            imageName: "f1",
            imageName2: "f1 2"
        )
    
        NavigationStack {
            MovieDetailView(movie: sampleMovie)
        }
}
