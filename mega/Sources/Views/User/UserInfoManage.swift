import Foundation
import SwiftUI

struct UserInfoManage: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var session: UserSession

    @State private var userId: String = ""
    @State private var tempName: String = ""

    var body: some View {
        VStack {
            topNav
                .padding(.horizontal, 14)

            Spacer().frame(height: 53)

            mainContent
                .padding(.horizontal, 14)
        }
        .navigationBarHidden(true)
        .onAppear {
            // 키체인에서 현재 값 로드
            userId = KeychainService.shared.read(service: KCKey.service, account: KCKey.userID) ?? ""
            tempName = KeychainService.shared.read(service: KCKey.service, account: KCKey.userName)
                ?? session.displayName
        }
        Spacer()
    }

    private var topNav: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "arrow.left")
                    .resizable()
                    .frame(width: 26, height: 22)
                    .foregroundStyle(Color.black)
            }
            .frame(width: 30, height: 44, alignment: .center)

            Spacer()

            Text("회원정보 관리")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.black)

            Spacer()

            Color.clear.frame(width: 30, height: 44)
        }
        .padding(.horizontal)
        .frame(height: 44)
    }

    private var mainContent: some View {
        VStack(alignment: .leading) {
            Text("기본정보")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.black)
                .padding(.bottom, 4)

            Text(userId)
                .font(.system(size: 14))
                .foregroundStyle(Color.black)
                .padding(.top, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)

            Divider().padding(.bottom, 24)

            HStack {
                TextField("이곳에 입력하세요", text: $tempName)
                    .font(.system(size: 14))
                    .padding(.top, 8)

                Button(action: {
                    _ = KeychainService.shared.save(
                        service: KCKey.service,
                        account: KCKey.userName,
                        value: tempName
                    )
                    session.displayName = tempName
                }) {
                    Text("변경")
                        .frame(width: 38, height: 20)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(Color("gray03"))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color("gray03"), lineWidth: 1)
                        )
                }
                .disabled(tempName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }

            Divider()
        }
    }
}

#Preview("iPhone 16 Pro") {
    UserInfoManage()
        .environmentObject(UserSession.shared)
}
