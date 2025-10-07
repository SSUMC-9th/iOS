//
//  ReservPosters.swift
//  mega
//
//  Created by 이경민 on 10/5/25.
//

import SwiftUI

struct ReservMovieCard: View {
    let movieInfo:ReservModel
    var isSelected: Bool=false
    
    var body: some View {
        VStack{
            movieInfo.movieImage
                .resizable()
                .aspectRatio(contentMode:.fit)
                .frame(width:62, height:89)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color("purple04") : Color.clear, lineWidth:2))
            
        }.frame(width:62, height:89)
        
    }

}

#Preview {
    ReservMovieCard(movieInfo: .init(movieImage: .init(.f1), movieName: "F1 더 무비", movieEngName: "F1: The Movie", movieReserCount: "누적관객수 10만"))
}
