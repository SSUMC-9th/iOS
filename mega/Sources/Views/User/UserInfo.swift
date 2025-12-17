import Foundation
import SwiftUI

struct UserInfo: View {
    @EnvironmentObject var session: UserSession
    @State private var isShowingManage: Bool = false
    
    @State private var profileImage: UIImage? = nil
    @State private var isShowingImagePicker: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            profileHeader
                .padding(.horizontal, 14)
                .padding(.top, 59)

            membershipPointSection
                .padding(.horizontal, 14)
                .padding(.top, 10)

            clubMembershipSection
                .padding(.horizontal, 14)
                .padding(.top, 15)

            statusInfoSection
                .padding(.horizontal, 14)
                .padding(.top, 33)

            bottomIconSection
                .padding(.horizontal, 14)
                .padding(.top, 33)

            Spacer()
        }
        .navigationDestination(isPresented: $isShowingManage) {
            UserInfoManage()
                .environmentObject(session)
        }
        .onAppear {
            // 세션 이름이 비어있으면 키체인에서 복원 (fallback: userID)
            if session.displayName.isEmpty {
                let name = KeychainService.shared.read(service: KCKey.service, account: KCKey.userName)
                    ?? KeychainService.shared.read(service: KCKey.service, account: KCKey.userID)
                    ?? ""
                session.displayName = name
            }
        }
        .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(image: $profileImage)
        }
    }

    private var profileHeader: some View {
        HStack(spacing: 0) {
            ZStack {
                if let image = profileImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.black)
                        .padding(6)
                }
            }
            .frame(width: 48, height: 48)
            .background(Color.white)
            .clipShape(Circle())
            .contentShape(Circle())
            .padding(.trailing, 4)
            .onLongPressGesture(minimumDuration: 1.0) {
                        isShowingImagePicker = true
            }
            
            Text("\(session.displayName.isEmpty ? "회원" : session.displayName)님")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.black)
                .lineLimit(1)
                .minimumScaleFactor(0.7)

            Text("WELCOME")
                .frame(height: 25)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color(hex: "#47CDD2"))
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .padding(.leading, 8)

            Spacer()

            Button(action: {
                isShowingManage = true
            }) {
                Text("회원정보")
                    .frame(width: 72, height: 28)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 4)
                    .background(Color("gray07"))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
    }

    // ===== 이하 기존 섹션은 그대로 =====

    private var membershipPointSection: some View {
        HStack(spacing: 0) {
            Text("멤버십 포인트")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color("gray04"))

            Text("500P")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(.black)
                .padding(.leading, 9)
        }
    }

    private var clubMembershipSection: some View {
        HStack {
            Text("클럽 멤버십")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.white)

            Image(systemName: "chevron.right")
                .foregroundStyle(.white)

            Spacer()
        }
        .padding(.leading, 8)
        .padding(.vertical, 12)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "#AB8BFF"),
                    Color(hex: "#8EAEF3"),
                    Color(hex: "#5DCCEC")
                ]),
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private var statusInfoSection: some View {
        HStack(spacing: 0) {
            VStack {
                Text("쿠폰")
                    .font(.system(size: 16))
                    .foregroundStyle(Color("gray02"))
                    .padding(.top, 12)
                    .padding(.bottom, 8)
                Text("2")
                    .font(.system(size: 16))
                    .foregroundStyle(Color(.black))
                    .padding(.bottom, 12)
            }

            verticalDivider

            VStack {
                Text("스토어 교환권")
                    .font(.system(size: 16))
                    .foregroundStyle(Color("gray02"))
                    .padding(.top, 12)
                    .padding(.bottom, 8)
                    .frame(width: 107)
                Text("0")
                    .font(.system(size: 16))
                    .foregroundStyle(Color(.black))
                    .padding(.bottom, 12)
            }

            verticalDivider

            VStack {
                Text("모바일 티켓")
                    .font(.system(size: 16))
                    .foregroundStyle(Color("gray02"))
                    .padding(.top, 12)
                    .padding(.bottom, 8)
                Text("0")
                    .font(.system(size: 16))
                    .foregroundStyle(Color(.black))
                    .padding(.bottom, 12)
            }
        }
        .frame(height: 76)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 24)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color("gray02"), lineWidth: 1)
        )
    }

    private var verticalDivider: some View {
        Rectangle()
            .frame(width: 1, height: 44)
            .foregroundStyle(Color("gray02"))
            .padding(.trailing, 23)
            .padding(.leading, 33)
    }

    private var bottomIconSection: some View {
        HStack {
            VStack(spacing: 12) {
                Image("film-reel")
                    .resizable()
                    .frame(width: 36, height: 36)
                Text("영화별예매")
                    .font(.system(size: 16))
            }
            .frame(maxWidth: .infinity)

            VStack(spacing: 12) {
                Image("pin-map")
                    .resizable()
                    .frame(width: 36, height: 36)
                Text("극장별예매")
                    .font(.system(size: 16))
            }
            .frame(maxWidth: .infinity)

            VStack(spacing: 12) {
                Image("film-sofa")
                    .resizable()
                    .frame(width: 36, height: 36)
                Text("특별관예매")
                    .font(.system(size: 16))
            }
            .frame(maxWidth: .infinity)

            VStack(spacing: 12) {
                Image("film-mobileorder")
                    .resizable()
                    .frame(width: 36, height: 36)
                Text("모바일오더")
                    .font(.system(size: 16))
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview("iPhone 16 Pro") {
    UserInfo()
        .environmentObject(UserSession.shared)
}
