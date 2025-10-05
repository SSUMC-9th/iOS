//
//  ReservView.swift
//  mega
//
//  Created by 이경민 on 10/5/25.
//

import Foundation
import SwiftUI

struct ReservView: View {
    @State private var viewModel: MegaMovieViewModel = .init()
    
    var body : some View {
        ScrollView{
            VStack(spacing: 0){
                topHeader
                movieName
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                moviePoster
                    .padding(.horizontal, 16)
                Spacer()
                
            }
        }
    }

    private var topHeader: some View{
        ZStack {
            Color("purple04")
                .ignoresSafeArea(edges: .top)
                
            Text("영화별 예매")
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(height: 71)
    }
    
    private var movieName: some View{
        HStack(spacing:0){
            Text("15")
                .font(.bold18)
                .foregroundStyle(Color.black)
                .background(Color("orangeTag"))
                .padding(.trailing, 37)
            
            Text("어쩔수가없다")
                .font(.PretendardSemiBold18)
                .frame(width:238, height: 24, alignment: .leading)
            
            Button(action:{
                
            }){
                Text("전체 영화")
                    .font(.semiBold14)
                    .foregroundStyle(Color.black)
            }.cornerRadius(8)
            .padding(10)
            
        }.frame(maxWidth: .infinity)
            .padding(.bottom, 20)
        
    }
    
    private var moviePoster: some View{
        ScrollView(.horizontal){
            LazyHStack(spacing:24){
                ForEach(viewModel.movieViewModel) { movie in
                    NavigationLink(destination: {MovieDetail(movie:movie)}){
                        MegaMovieCard(movieInfo: movie)
                    }
                }
            }
        }.frame(height:89)
        .scrollIndicators(.hidden)
    }
}

#Preview{
    ReservView()
}
