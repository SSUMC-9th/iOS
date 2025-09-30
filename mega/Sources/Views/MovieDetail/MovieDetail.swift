//
//  MovieDetail.swift
//  mega
//
//  Created by 이경민 on 9/30/25.
//

import Foundation
import SwiftUI

struct MovieDetail:View {
    private let movieDescription: String = "최고가 되지 못한 전설 vs 최고가 되고 싶은 루키\n\n한때 주목받는 유망주였지만 끔찍한 사고로 F1에서 우승하지 못하고\n한순간에 추락한 드라이버 '손; 헤이스'(브래드 피트).\n그의 오랜 동료인 '루벤 세르반테스'(하비에르 바르뎀)에게 레이싱 복귀를 제안받으며 최하위 팀인 APXGP에 합류한다."
    
    var body: some View {
        VStack(spacing: 0){
            movieDetailHeader
                .padding(.horizontal, 16)
            movieSummarize
            movieTabHeader
            Spacer()
        }.frame(maxWidth:.infinity, maxHeight: .infinity)
    }
    
    private var movieDetailHeader: some View {
        HStack{
            Image(systemName: "arrow.left")
                .resizable()
                .frame(width:39, height:39)
                .aspectRatio(contentMode: .fit)
            Spacer()
            Text("F1 더 무비")
                .font(.PretendardRegular16)
            Spacer()
                .frame(width: 150)
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
                Text("F1 더 무비")
                    .font(.bold24)
            }.frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
            
            HStack{
                Text("F1 더 무비")
                    .font(.semiBold14)
                    .foregroundStyle(Color("gray03"))
            }.frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
            
            Text(movieDescription)
                .font(.PretendardRegular16)
                .lineSpacing(4)
                .padding(.top, 10)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var movieTabHeader: some View{
        HStack{
            Button(action:{
                
            }){
                Text("상세 정보")
            }
            
            Button(action:{
                
            }){
                Text("실관람평")
            }
            
        }.frame(maxWidth:.infinity, minHeight: 35)
    }
}

#Preview {
    MovieDetail()
}
