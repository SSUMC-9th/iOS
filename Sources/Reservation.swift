//
//  Untitled.swift
//  megabox
//
//  Created by 문인성 on 10/9/25.
//

import SwiftUI

struct Reservation: View {
    private let imageNames: [String] = [
            "poster1",
            "poster2",
            "poster3",
            "poster4",
            "poster5",
            "poster6",
            "poster7",
            "poster8"
        ]
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color("purple04"))
                .frame(height: 125)
            Text("영화별 예매")
                .foregroundStyle(Color.white)
        }
        
        HStack {
            ZStack {
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.orange)
                    .frame(width: 50, height: 50)
                
                Text("15")
                .font(.bold24)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
            }
            .padding(.leading, 16)
            
            HStack {
                Text("어쩔 수가 없다")
                    .font(.bold18)
                    .padding(.leading, 37)
                Spacer()
                Text("전체 영화")
                .padding(10)
                .background(.white)
                .cornerRadius(8)
                .overlay(
                RoundedRectangle(cornerRadius: 8)
                .inset(by: 0.5)
                .stroke(Color(red: 0.84, green: 0.84, blue: 0.84), lineWidth: 1)
                
                )
            }
            .padding(.trailing, 16)
            
        }
        Spacer()
        
        VStack(alignment: .leading, spacing: 10) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(0..<imageNames.count, id: \.self) { index in
                                
                                VStack {
                                    Image(imageNames[index])
                                        .resizable()
                                        .scaledToFill()
                                        .cornerRadius(8)
                                        .clipped()
                                        .frame(width: 62, height: 89)
                                }
                                
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 140)
                }
        
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
    }
}

#Preview {
    Reservation()
}
