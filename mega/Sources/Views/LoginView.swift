//
//  LoginView.swift
//  mega
//
//  Created by 이경민 on 9/19/25.
//

import Foundation
import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            // 상단 네비게이션 바
            HStack {
                Spacer()
                Text("로그인")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                Spacer()
            }
            Spacer().frame(height:80)
            // 아이디 및 비밀번호 입력
            VStack(spacing: 0) {
                VStack(alignment: .leading) {
                    TextField("아이디", text: .constant(""))
                    Divider()
                }.padding(.bottom, 30)
                
                VStack(alignment: .leading) {
                    SecureField("비밀번호", text: .constant(""))
                    Divider()
                }
            }
            .padding(.horizontal, 16)
            
            // 로그인 버튼
            Button(action: {}) {
                Text("로그인")
                    .font(.PretendardSemiBold18)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
            }
            .background(Color("purple03"))
            .cornerRadius(10)
            .padding(.horizontal, 16)
            .padding(.top, 37.5)

            
            // 회원가입하기
            Text("회원가입")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.bottom, 25)
                .padding(.top, 10)
            
            // 소셜 로그인
            HStack(spacing: 53) {
                Image("naverLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40)

                Image("kakaoLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40)
                
                Image("appleLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40)
            }
            
            // 포스터 이미지
            Image("umcLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, 39)
                .padding(.horizontal, 16)
            
            Spacer()
        }
    }
}


#Preview {
    LoginView()
}

#Preview("iPhone 11") {
    LoginView()
}

#Preview("iPhone 16 Pro") {
    LoginView()
}

