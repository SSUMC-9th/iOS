import Foundation
import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var viewModel = LoginViewModel(loginModel: LoginModel(id: "", pwd: ""))

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("로그인")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.black)
                Spacer()
            }
            Spacer().frame(height: 80)

            VStack(spacing: 0) {
                VStack(alignment: .leading) {
                    TextField("아이디", text: $viewModel.loginModel.id)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    Divider()
                }.padding(.bottom, 30)

                VStack(alignment: .leading) {
                    SecureField("비밀번호", text: $viewModel.loginModel.pwd)
                    Divider()
                }
            }
            .padding(.horizontal, 16)

            // 로그인 버튼
            Button {
                // 서버 검증 로직이 있다면 여기에서 인증 후 저장
                let saved = viewModel.registerToKeychain()
                if saved {
                    UserSession.shared.displayName = viewModel.loginModel.id
                    UserSession.shared.isLoggedIn = true
                    isLoggedIn = true
                } else {
                    print("키체인 저장 실패")
                }
            } label: {
                Text("로그인")
                    .font(.PretendardSemiBold18)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
            }
            .background(Color("purple03"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 16)
            .padding(.top, 37.5)

            Text("회원가입")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.bottom, 25)
                .padding(.top, 10)

            HStack(spacing: 53) {
                Image("naverLogo").resizable().aspectRatio(contentMode: .fit).frame(width: 40)
                
                Button {
                    viewModel.loginWithKakaoREST { ok in
                        if ok { isLoggedIn = true }
                    }
                } label: {
                        Image("kakaoLogo").resizable().aspectRatio(contentMode: .fit).frame(width: 40)
                }
                
                Image("appleLogo").resizable().aspectRatio(contentMode: .fit).frame(width: 40)
            }

            Image("umcLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, 39)
                .padding(.horizontal, 16)

            Spacer()
        }
        .onAppear {
            if viewModel.tryAutoLogin() {
                isLoggedIn = true
            }
        }
    }
}

#Preview("iPhone 16 Pro") {
    @Previewable @State var previewIsLoggedIn: Bool = false
    return LoginView(isLoggedIn: $previewIsLoggedIn)
}
