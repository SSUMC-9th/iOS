//
//  LoginView.swift
//  megabox
//
//  Created by 김세은 on 9/23/25.
//

import SwiftUI


struct LoginView: View {
    @EnvironmentObject var router: NavigationRouter
    @StateObject var loginViewModel: LoginViewModel
    @AppStorage("savedId") private var savedId: String = ""
    @AppStorage("savedPwd") private var savedPwd: String = ""
    @AppStorage("savedName") private var savedName: String = ""
    
    init() {
        self._loginViewModel = .init(wrappedValue: LoginViewModel(loginModel: LoginModel(id:"", pwd: "")))
    }
    
    var body: some View {
        
        ZStack {
            Color.white
                .ignoresSafeArea()   // 안전 영역(노치, 홈바 영역)까지 채우기
            VStack {
                Group{
                    navigatorViewGroup
                    Spacer()
                    
                    loginInputViewGroup
                    Spacer()
                    loginButton
                    Spacer()
                        .frame(height: 17)
                    signUpText
                    Spacer()
                    socialLoginGroup
                    
                    Spacer()
                        .frame(height: 39)
                    
                    promotionImage
                    Spacer()
                }
        
            }
            .padding(.horizontal, 16)     // 좌우 여백
        }
        

    }
    
    private var navigatorViewGroup: some View {
        HStack {
            Text("로그인")
                .font(.semiBold24)
                .foregroundColor(.black)
        }
    }
    
    private var loginInputViewGroup: some View {
        VStack {
            TextField("아이디", text: $loginViewModel.loginModel.id)
            
            Divider()               // 구분선
                .frame(maxWidth: .infinity)
                .background(Color("gray02"))
            
            Spacer()
                .frame(height: 40)
            
            SecureField("비밀번호", text: $loginViewModel.loginModel.pwd)
            
            Divider()               // 구분선
                .frame(maxWidth: .infinity)
                .background(Color("gray02"))
        }
    }
    
    private var loginButton: some View {
        Button(action: {
//            print("현재 입력된 아이디:", loginViewModel.loginModel.id)
//            print("현재 입력된 비번:", loginViewModel.loginModel.pwd)
            savedId = loginViewModel.loginModel.id
            savedPwd = loginViewModel.loginModel.pwd
            savedName = loginViewModel.loginModel.id + "_init"
            router.push(.mainTab)
            
//            print("저장 완료 - id:\(savedId), name:\(savedName)")
        }) {
            Text("로그인")
                .font(.bold18)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 54, maxHeight: 54)
                .background(Color("purple03"))
                .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, minHeight: 54, maxHeight: 54, alignment: .center)
    }
    
    private var signUpText: some View {
        Text("회원가입")
            .font(.medium13)
            .foregroundColor(Color("gray04"))
    }
    
    private var socialLoginGroup: some View {
        HStack {
            Button(action: {}) {
                Image("naver")
            }
            
            Spacer()
            
            Button(action: {}) {
                Image("kakao")
            }
            
            Spacer()
            
            Button(action: {}) {
                Image("apple")
            }
        }
        .frame(width: 266, height: 40, alignment: .top)
    }
    
    private var promotionImage: some View {
        Image("umc")
            .resizable()
            .scaledToFit()             // 가로 크기에 맞춰 세로 자동 조절
            .frame(maxWidth: .infinity)   // 부모 VStack 폭 꽉 채우기
    }
}

#Preview {
    LoginView()
}

#Preview("iPhone 11") {
    LoginView()
}

#Preview("iPhone 16 Pro Max") {
    LoginView()
}
