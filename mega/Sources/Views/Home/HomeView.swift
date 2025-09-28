//
//  MainView.swift
//  mega
//
//  Created by 이경민 on 9/28/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView{
            VStack{
                megaLogo
            }.padding(.horizontal, 16)
        }
    }
    
    private var megaLogo: some View {
        HStack{
            Image("megaLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 149, height: 30, alignment: .leading)
        }
    }
    
}

#Preview {
    HomeView()
}
