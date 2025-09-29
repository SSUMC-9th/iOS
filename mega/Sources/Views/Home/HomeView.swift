//
//  MainView.swift
//  mega
//
//  Created by 이경민 on 9/28/25.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("movieName") private var movieName: String = ""
    private var viewModel: MegaMovieViewModel = .init()
    
    var body: some View {
        ScrollView{
            VStack(spacing:0){
                megaLogo
                    .padding(.bottom, 8)
                topSegment4
                    .padding(.bottom, 9)
                topSegment2
                    .padding(.bottom, 25)
                moviePoster
                
            }.padding(.leading, 16)
            
        }.frame(maxWidth: .infinity, maxHeight:.infinity)
        .background(Color.white)
    }
    
    private var megaLogo: some View {
        HStack{
            Image("megaLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 149, height: 30, alignment: .leading)
            Spacer()
        }.frame(maxWidth: .infinity)
    }
    
    private var topSegment4: some View {
        HStack(spacing:31){
            Text("홈")
                .font(.PretendardSemiBold24)
                .fontWeight(.bold)
                .foregroundStyle(Color.black)
            Text("이벤트")
                .font(.PretendardSemiBold24)
                .fontWeight(.bold)
                .foregroundStyle(Color("gray04"))
            Text("스토어")
                .font(.PretendardSemiBold24)
                .fontWeight(.bold)
                .foregroundStyle(Color("gray04"))
            Text("선호극장")
                .font(.PretendardSemiBold24)
                .fontWeight(.bold)
                .foregroundStyle(Color("gray04"))
            Spacer()
        }.frame(maxWidth:.infinity, minHeight:36)
    }
    
    private var topSegment2:some View {
        HStack(spacing: 23) {
            Button(action: {
                
            }) {
                Text("무비차트")
                    .font(.PretendardSemiBold18)
                    .frame(width: 84, height: 38)
                    .foregroundStyle(Color.white)
                    
            }
            .background(Color("gray08"))
            .cornerRadius(19)
            
            Button(action: {
                
            }) {
                Text("상영예정")
                    .font(.PretendardSemiBold18)
                    .frame(width: 84, height: 38)
                    .foregroundStyle(Color("gray04"))
            }
            .background(Color("gray02"))
            .cornerRadius(19)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var moviePoster:some View {
        ScrollView(.horizontal){
            HStack(spacing:24){
                MegaMovieCard(movieInfo: viewModel.movieViewModel[viewModel.currentIndex])
            }
        }
    }
}

#Preview {
    HomeView()
}
