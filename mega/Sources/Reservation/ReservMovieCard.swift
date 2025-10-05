//
//  ReservPosters.swift
//  mega
//
//  Created by 이경민 on 10/5/25.
//

import SwiftUI

struct ReservMovieCard: View {
    let movieInfo:ReservModel
    
    init(movieInfo:ReservModel){
        self.movieInfo = movieInfo
    }
    
    var body: some View {
        VStack{
            movieInfo.movieImage
                .resizable()
                .aspectRatio(contentMode:.fit)
                .frame(width:148, height:212)
                .cornerRadius(10)
            
        }.frame(width:148, height:318)
        
    }

}

#Preview {
    ReservMovieCard(movieInfo: .init(movieImage: .init(.f1), movieName: "F1 더 무비", movieEngName: "F1: The Movie", movieReserCount: "누적관객수 10만"))
}
