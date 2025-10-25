//
//  LoginView.swift
//  mega
//
//  Created by 이경민 on 9/19/25.
//

import Foundation
import SwiftUI

struct LoginView: View {
    // AppStorage 사용해서 아이디 비번 저장하는 변수
    @AppStorage("userID") var storedID:String="kmin817"
    @AppStorage("userPWD") var storedPWD:String="0000"
    @Binding var isLoggedIn: Bool
    
    @State private var viewModel = LoginViewModel(loginModel:LoginModel(id: "", pwd: ""))
    
    
    var body: some View {
        VStack {
            // 상단 네비게이션 바
            HStack {
                Spacer()
                Text("로그인")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.black)
                Spacer()
            }
            Spacer().frame(height:80)
            // 아이디 및 비밀번호 입력
            VStack(spacing: 0) {
                VStack(alignment: .leading) {
                    TextField("아이디", text: $viewModel.loginModel.id)
                    Divider()
                }.padding(.bottom, 30)
                
                VStack(alignment: .leading) {
                    SecureField("비밀번호", text: $viewModel.loginModel.pwd)
                    Divider()
                }
            }
            .padding(.horizontal, 16)
            
            // 로그인 버튼
            Button(action: {
                if viewModel.loginModel.id == storedID && viewModel.loginModel.pwd == storedPWD {
                    self.isLoggedIn = true
                } else {
                    print("로그인 실패: 아이디 또는 비밀번호가 일치하지 않습니다.")}
            }) {Text("로그인")
                    .font(.PretendardSemiBold18)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)}
                .background(Color("purple03"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
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

#Preview("iPhone 11") {
    @Previewable @State var previewIsLoggedIn: Bool = false
    return LoginView(isLoggedIn: $previewIsLoggedIn)
}

#Preview("iPhone 16 Pro") {
    @Previewable @State var previewIsLoggedIn: Bool = false
    return LoginView(isLoggedIn: $previewIsLoggedIn)
}

