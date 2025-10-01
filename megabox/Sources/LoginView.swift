//
//  LoginView.swift
//  megabox
//
//  Created by 문인성 on 9/24/25.
//

    import SwiftUI

    struct LoginView: View {

        @Environment(LoginViewModel.self) private var viewModel
        
        @State private var showAlert: Bool = false
        
        @AppStorage("saved_id") private var savedId: String = "swift"
        @AppStorage("saved_pwd") private var savedPwd: String = "1234"

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
                        
                        if viewModel.loginInfo.id == savedId && viewModel.loginInfo.pwd == savedPwd {
                            
                            viewModel.isLoggedIn = true
                        } else {

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
                        .font(.mediudm13)
                        .foregroundStyle(Color.gray) // Color("gray04")
                }
                
                Spacer()
            }
            
            .alert("로그인 실패", isPresented: $showAlert) {
                Button("확인", role: .cancel) {}
            } message: {
                Text("아이디 또는 비밀번호를 확인해주세요.")
            }
        }
    }

    
    struct LoginView_Previews: PreviewProvider {
        static let devices = [ "iPhone 16 Pro Max", "iPhone 11"]

        static var previews: some View {
            ForEach(devices, id: \.self) { device in
                LoginView()
                    
                    .environment(LoginViewModel())
                    .previewDevice(PreviewDevice(rawValue: device))
                    .previewDisplayName(device)
            }
        }
    }
