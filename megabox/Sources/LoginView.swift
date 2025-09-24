//
//  LoginView.swift
//  megabox
//
//  Created by 문인성 on 9/24/25.
//

import SwiftUI



struct LoginView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("로그인")
                    .font(.semiBold24)
                    .foregroundStyle(Color("black"))
                    .padding(.top, 44)
            }
            
            Spacer()
            
            VStack {
                TextField("아이디", text: $username)
                    .padding(.horizontal, 16)
                Divider()
                    .padding(.horizontal, 16)
                
                SecureField("비밀번호", text: $password)
                    .padding(.horizontal, 16)
                Divider()
                    .padding(.horizontal, 16)
                    .padding(.bottom, 74.98)
                
                Button(action: {
                    // 버튼이 눌렸을 때 실행할 코드 (예: 알림 표시)
                    print("로그인 되었습니다!")
                }) {
                    // 버튼에 표시될 내용
                    Text("로그인")
                        .font(.bold18)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 9)
                        .background(Color("purple03"))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 16.5)
                .padding(.bottom, 17)
                
                Text("회원가입")
                    .font(.medium13)
                    .foregroundStyle(Color("gray04"))
            }
            
            
            
            HStack {
                Image("naverLoginBtn")
                Spacer()
                Image("kakaoLoginBtn")
                Spacer()
                Image("appleLoginBtn")
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 35)
            .padding(.horizontal, 87)
            .padding(.bottom, 39)
            
            HStack {
                Spacer()
            
                Image("umc")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                
                Spacer()
            }
            
            Spacer()
        }
    }
}

struct PreviewWrapper: View {
    @State private var test = ""
    
    var body: some View {
        TextEditor(text: $test)
            .frame(height: 100)
            .border(Color.gray, width: 1)
    }
}

struct PreviewWrapper_previews: PreviewProvider {
    static let devices = [ "iPhone 16 Pro Max",
                           "iPhone 11"]

    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            LoginView()
                .previewDevice(PreviewDevice(rawValue: device)) // 프리뷰 디바이스 설정
                .previewDisplayName(device) // 프리뷰 이름 설정
        }
    }
}
