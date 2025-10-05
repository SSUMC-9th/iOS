//
//  ReservView.swift
//  mega
//
//  Created by 이경민 on 10/5/25.
//

import Foundation
import SwiftUI

struct ReservView: View {
    @State private var viewModel: ReservViewModel = .init()
    @State private var selectedMovie: ReservModel?

    
    var body : some View {
        ScrollView{
            VStack(spacing: 0){
                topHeader
                    .padding(.bottom, 2)
                movieName
                    .padding(.horizontal, 16)
                moviePoster
                    .padding(.horizontal, 16)
                    .padding(.bottom, 32)
                theaterPlace
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
            
            Text(selectedMovie?.movieName ?? "영화 선택")
                .font(.PretendardSemiBold18)
                .frame(width: 238, height: 24, alignment: .leading)
            
            Button(action:{
                
            }){
                Text("전체영화")
                    .font(.semiBold14)
                    .foregroundStyle(Color.black)
                    .frame(width:49, height:20)
                    .padding(10)
            }
            
        }.frame(maxWidth: .infinity)
    }
    
    private var moviePoster: some View{
        ScrollView(.horizontal){
            LazyHStack(spacing:8){
                ForEach(viewModel.movieViewModel) { movie in
                        ReservMovieCard(
                            movieInfo: movie,
                            isSelected: selectedMovie?.id == movie.id
                        ).onTapGesture {
                            selectedMovie = movie
                        }
                }
            }
        }.frame(height:89)
        .scrollIndicators(.hidden)
    }
    
    private var theaterPlace: some View{
        HStack(spacing:8){
            Button(action:{
                
            }){
                Text("강남")
                    .font(.semiBold16)
                    .foregroundColor(Color("gray05"))
                    .frame(width: 35, height: 15)
                    .padding(10)
                    .background(Color("gray01"))
                    .cornerRadius(15)
            }
            .frame(width:55, height:35)
            
            Button(action:{
                
            }){
                Text("홍대")
                    .font(.semiBold16)
                    .foregroundColor(Color("gray05"))
                    .frame(width: 35, height: 15)
                    .padding(10)
                    .background(Color("gray01"))
                    .cornerRadius(15)
            }
            .frame(width: 55, height: 35)
            
            Button(action:{
                
            }){
                Text("신촌")
                    .font(.semiBold16)
                    .foregroundColor(Color("gray05"))
                    .frame(width: 35, height: 15)
                    .padding(10)
                    .background(Color("gray01"))
                    .cornerRadius(15)
            }
            .frame(width: 55, height: 35)
            
            Spacer()
        }.frame(maxWidth:.infinity, minHeight:35)
    }
}

#Preview{
    ReservView()
}
