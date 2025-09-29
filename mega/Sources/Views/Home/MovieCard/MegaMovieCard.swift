//
//  MegaMovieCard.swift
//  mega
//
//  Created by 이경민 on 9/29/25.
//

import SwiftUI

struct MegaMovieCard: View {
    let movieInfo:MegaMovieModel
    
    init(movieInfo:MegaMovieModel){
        self.movieInfo = movieInfo
    }
    
    var body: some View {
        VStack{
            movieInfo.movieImage
                .resizable()
                .aspectRatio(contentMode:.fit)
                .frame(width:148, height:212)
            
            reserveBtn
            movieSubInfo
            
        }.frame(width:148, height:318)
    }
    
    
    private var reserveBtn: some View {
        Button(action:{
            
        }){
            Text("바로 예매")
                .font(.PretendardSemiBold18)
                .foregroundStyle(Color("purple03"))
        }
        .frame(width: 148, height:36)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("purple03"), lineWidth: 2)
        )
    }
    
    private var movieSubInfo:some View {
        VStack(spacing: 0){
            Text(movieInfo.movieName)
                .font(.bold22)
                .frame(width:149, height: 30, alignment: .leading)
            
            Text(movieInfo.movieReserCount)
                .font(.medium18)
                .frame(width:149, height: 21, alignment: .leading)
        }
    }
}

#Preview {
    MegaMovieCard(movieInfo: .init(movieImage: .init(.f1), movieName: "F1 더 무비", movieReserCount: "누적관객수 10만"))
}
