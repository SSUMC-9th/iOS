// LoginView.swift

import SwiftUI

struct LoginView: View {

    @StateObject private var viewModel: LoginViewModel
        
    init(viewModel: LoginViewModel) {
            _viewModel = StateObject(wrappedValue: viewModel)
        }
        
    @State private var showAlert: Bool = false

    var body: some View {
        VStack {
            HStack {
                Text("로그인")
                    .font(.semiBold24)
                    .padding(.top, 44)
            }
                
            Spacer()
                
            VStack {
                TextField("아이디", text: $viewModel.loginInfo.id)
                    .padding(.horizontal, 16)
                Divider()
                    .padding(.horizontal, 16)
                    
                SecureField("비밀번호", text: $viewModel.loginInfo.pwd)
                    .padding(.horizontal, 16)
                Divider()
                    .padding(.horizontal, 16)
                    .padding(.bottom, 74.98)
                    
                
                Button(action: {
                    
                    viewModel.handleLogin()
                    
                    if !viewModel.isLoggedIn {
                        showAlert = true
                    }
                    
                }) {
                    Text("로그인")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 9)
                        .background(Color.purple) // Color("purple03")
                        .cornerRadius(10)
                }
                .padding(.horizontal, 16.5)
                .padding(.bottom, 17)
                    
                Text("회원가입")
                    .font(.medium13)
                    .foregroundStyle(Color.gray) // Color("gray04")
            }

        }
            
        .alert("로그인 실패", isPresented: $showAlert) {
            Button("확인", role: .cancel) {}
        } message: {
            Text("아이디 또는 비밀번호를 확인해주세요.")
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
            Image("umc")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
        }
        
        Spacer()

    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}
