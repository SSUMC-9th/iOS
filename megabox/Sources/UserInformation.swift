//
//  UserInfromation.swift
//  megabox
//
//  Created by 문인성 on 9/25/25.
//

import SwiftUI

struct UserInformation: View {
    @AppStorage("saved_id") private var savedId: String = ""
    
    var body: some View {
        
        VStack {
            HStack {
                Text("\(savedId)" + "님")
                    .font(.bold24)
                    .padding(.leading, 16)
                    .padding(.trailing, 5)
                
                Spacer()
                
                Text("Welcome")
                    .font(.medium14)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color("tag"))
                    .cornerRadius(6)
                    
                Spacer()
                    .frame(minWidth: 135)
                
                Button(action: {
                    
                }) {
                    
                    Text("회원정보")
                        .font(.semiBold14)
                        .foregroundStyle(.white)
                        .frame(width: 64, height: 20)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 4)
                        .background(Color("gray07"))
                        .cornerRadius(16)
                        .padding(.trailing, 16)
                }
            }
            .padding(.top, 59)
            
            
            HStack {
               Text("멤버쉽 포인트")
                    .font(.semiBold14)
                    .foregroundStyle(Color("gray04"))
                    .padding(.leading, 16)
                
               Text("500P")
                    .padding(.leading, 9)
                Spacer()
            }
            
            Button(action: {
                
            }) {
                HStack {
                    Text("클럽 멤버쉽")
                        .font(.semiBold16)
                    
                    Image("arrow")
                }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 8)
                    .padding(.vertical, 12)
                    .background(
                        LinearGradient (
                            gradient: Gradient(colors: [
                                Color(hex: "#AB8BFF"),
                                Color(hex: "#8EAEF3"),
                                Color(hex: "#5DCCEC")
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing)
                        )
                    .cornerRadius(8)
            }
            .padding(.top, 15)
            .padding(.horizontal, 15)
            .padding(.bottom, 33)
            
            HStack {
                VStack {
                    Text("쿠폰")
                        .font(.semiBold16)
                        .foregroundStyle(Color("gray02"))
                    Text("2")
                        .font(.semiBold18)
                }
                
                Rectangle()
                    .foregroundColor(Color("gray02"))
                    .frame(width: 1, height: 31)
                    .padding(.horizontal, 20)
                
                VStack {
                    Text("스토어 교환권")
                        .font(.semiBold16)
                        .foregroundStyle(Color("gray02"))
                    Text("0")
                        .font(.semiBold18)
                }
                
                Rectangle()
                    .foregroundColor(Color("gray02"))
                    .frame(width: 1, height: 31)
                    .padding(.horizontal, 20)
                
                VStack {
                    Text("모바일 티켓")
                        .font(.semiBold16)
                        .foregroundStyle(Color("gray02"))
                    Text("0")
                        .font(.semiBold18)
                }
            }
            .frame(width: 362, height: 52)
            .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(Color("gray02")), lineWidth: 1)
                    )
            .padding(.bottom, 33)
            
            HStack {
                VStack {
                       Image("film_reel")
                        Text("영화별 예매")
                        .font(.medium16)
                }
                .padding(.leading, 16)
                Spacer()
                
                VStack {
                       Image("pin_map")
                        Text("극장별 예매")
                        .font(.medium16)
                }
                
                Spacer()
                
                VStack {
                       Image("sofa")
                        Text("특별관 예매")
                        .font(.medium16)
                }
                
                Spacer()
                
                VStack {
                       Image("popcorn")
                    Text("모바일오더")
                        .font(.medium16)
                }
                .padding(.trailing, 16)
            }
            Spacer()
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#") // # 문자 제거
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb) // 16진수를 정수로 변환
        
        // RGB 값 분리
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}

#Preview {
    UserInformation()
}
