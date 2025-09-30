//
//  MovieDetail.swift
//  mega
//
//  Created by 이경민 on 9/30/25.
//

import Foundation
import SwiftUI

struct MovieDetail:View {
    @Environment(\.dismiss) private var dismiss
    
    let movie:MegaMovieModel
    private let movieDescription: String = "최고가 되지 못한 전설 vs 최고가 되고 싶은 루키\n\n한때 주목받는 유망주였지만 끔찍한 사고로 F1에서 우승하지 못하고\n한순간에 추락한 드라이버 '손; 헤이스'(브래드 피트).\n그의 오랜 동료인 '루벤 세르반테스'(하비에르 바르뎀)에게 레이싱 복귀를 제안받으며 최하위 팀인 APXGP에 합류한다."
    
    var body: some View {
        VStack(spacing: 0){
            topNavigationBar
                .padding(.horizontal, 16)
            movieSummarize
                .padding(.bottom, 35)
            movieTabHeader
                .padding(.bottom, 17)
            movieSubInfo
                .padding(.horizontal, 16)
            Spacer()
        }.frame(maxWidth:.infinity, maxHeight: .infinity)
        .navigationTitle(movie.movieName)
        .navigationBarHidden(true)
    }
    
    private var topNavigationBar: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.black)
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
            Text(movie.movieName)
                .font(.PretendardRegular16)
                .foregroundColor(.black)
            
            Spacer().frame(width:150)
        }
        .frame(maxWidth:.infinity, minHeight: 54)
    }
    
    private var movieSummarize: some View{
        VStack{
            Image("movieDetailPoster")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
            HStack{
                Text(movie.movieName)
                    .font(.bold24)
            }.frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
            
            HStack{
                Text(movie.movieEngName)
                    .font(.semiBold14)
                    .foregroundStyle(Color("gray03"))
            }.frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
            
            Text(movieDescription)
                .font(.PretendardRegular16)
                .foregroundStyle(Color("gray03"))
                .lineSpacing(4)
                .padding(.top, 10)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var movieTabHeader: some View{
        HStack(spacing:0){
            Button(action:{
                
            }){
                Text("상세 정보")
                    .font(.bold22)
                    .foregroundStyle(Color.black)
            }.frame(maxWidth: .infinity, minHeight: 35)
            
            Button(action:{
                
            }){
                Text("실관람평")
                    .font(.bold22)
                    .foregroundStyle(Color("gray03"))
            }.frame(maxWidth: .infinity, minHeight: 35)
            
        }.frame(maxWidth:.infinity, minHeight: 35)
    }
    
    private var movieSubInfo: some View{
        HStack(spacing:0){
            movie.movieImage
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height:120)
            
            VStack(alignment: .leading){
                Text("12세 이상 관람")
                    .font(.semiBold13)
                    .padding(.bottom, 9)
                
                Text("123123")
                    .font(.semiBold13)
                Spacer()
            }.padding(.leading, 13)
            Spacer()
            
        }.frame(maxWidth:.infinity, maxHeight: 120)
    }
}

#Preview {
    MovieDetail(movie:MegaMovieModel(movieImage: Image("f1"), movieName: "F1 더 무비", movieEngName: "F1: The Movie", movieReserCount: "누적관객수 10만"))
}
