//
//  MegaMovieCard.swift
//  mega
//
//  Created by 이경민 on 9/29/25.
//

//import SwiftUI
//
//struct MegaMovieCard: View {
//    let movieInfo:MegaMovieModel
//    
//    init(movieInfo:MegaMovieModel){
//        self.movieInfo = movieInfo
//    }
//    
//    var body: some View {
//        VStack{
//            movieInfo.movieImage
//                .resizable()
//                .aspectRatio(contentMode:.fit)
//                .frame(width:148, height:212)
//            
//            reserveBtn
//            movieSubInfo
//            
//        }.frame(width:148, height:318)
//    }
//    
//    
//    private var reserveBtn: some View {
//        Button(action:{
//            
//        }){
//            Text("바로 예매")
//                .font(.PretendardSemiBold18)
//                .foregroundStyle(Color("purple03"))
//        }
//        .frame(width: 148, height:36)
//        .overlay(
//            RoundedRectangle(cornerRadius: 10)
//                .stroke(Color("purple03"), lineWidth: 2)
//        )
//    }
//    
//    private var movieSubInfo:some View {
//        VStack(spacing: 0){
//            Text(movieInfo.movieName)
//                .font(.bold22)
//                .frame(width:149, height: 30, alignment: .leading)
//            
//            Text(movieInfo.movieReserCount)
//                .font(.medium18)
//                .frame(width:149, height: 21, alignment: .leading)
//        }
//    }
//}
//
//#Preview {
//    MegaMovieCard(movieInfo: .init(movieImage: .init(.f1), movieName: "F1 더 무비", movieEngName: "F1: The Movie", movieReserCount: "누적관객수 10만"))
//}
import SwiftUI
import Kingfisher

struct MegaMovieCard: View {
    let movie: MovieCardModel

    init(movie: MovieCardModel) {
        self.movie = movie
    }

    var body: some View {
        VStack(spacing: 8) {
            KFImage(movie.posterURL)
                .placeholder {
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.1))
                            .frame(width: 148, height: 212)
                            .cornerRadius(10)
                        ProgressView()
                    }
                }
                .retry(maxCount: 2, interval: .seconds(1))
                .cancelOnDisappear(true)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 148, height: 212)
                .cornerRadius(10)
                .clipped()
                .shadow(radius: 3)

            reserveBtn
            movieSubInfo
        }
        .frame(width: 148, height: 318)
    }

    private var reserveBtn: some View {
        Button(action: {
            // TODO: 예매 액션
        }) {
            Text("바로 예매")
                .font(.PretendardSemiBold18)
                .foregroundColor(Color("purple03"))
                .frame(width: 148, height: 36)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("purple03"), lineWidth: 2)
                )
        }
    }

    private var movieSubInfo: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(movie.title)
                .font(.bold22)
                .frame(width: 149, height: 30, alignment: .leading)
                .lineLimit(1)

            Text("누적관객수 \(movie.cumulativeAudience.formatted())명")
                .font(.medium18)
                .frame(width: 149, height: 21, alignment: .leading)
        }
    }
}

#Preview {
    MegaMovieCard(
        movie: MovieCardModel(
            id: 1,
            title: "기생충",
            posterURL: URL(string: "https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg"),
            cumulativeAudience: 1234567
        )
    )
}
