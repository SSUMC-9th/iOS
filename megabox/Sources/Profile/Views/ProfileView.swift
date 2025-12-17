//
//  ProfileView.swift
//  megabox
//
//  Created by 김세은 on 9/28/25.
//
import SwiftUI


struct ProfileView: View {
    @AppStorage("savedName") private var savedName: String = ""
    @EnvironmentObject var router: NavigationRouter   // 추가

    //프로필 사진 기능
    @State private var showImagePicker = false
    @State private var selectedImages: [UIImage] = []
    
    private var selectedImage: UIImage? {
        selectedImages.first
    }
    
    var body: some View {
        
        ZStack {
            Color.white
                .ignoresSafeArea()   // 안전 영역(노치, 홈바 영역)까지 채우기
            VStack {
                HStack {
                    profileImageView
                    VStack {
                        headerView
                        memberShipPointView
                    }
                }
                .padding(.top, 59)   // 상단 여백
                
                clubMembershipButtonView
                    .padding(.top, 15)
                
                myTicketView
                    .padding(.top, 33)
                
                orderNavigatorView
                    .padding(.top, 33)
                
                Spacer()   // 아래는 남는 공간 차지
                Button("테스트용 로그아웃") {
                    KeychainHelper.shared.delete(account: "savedId")
                    KeychainHelper.shared.delete(account: "savedPwd")
                    KeychainHelper.shared.delete(account: "savedName")
                    print("🗑️ Keychain 삭제 완료!")
                    router.reset()  // 네비게이션 스택 초기화
                    router.push(.login)
                }
                .foregroundColor(.red)
                .padding(.top, 20)
            }
            .padding(.horizontal, 16)
            
            
        }
        .onAppear {
            if let name = KeychainHelper.shared.read(forKey: "savedName") {
                savedName = name
                print("ProfileView 갱신 : \(name)")
            } else {
                savedName = ""
                print("Keychain에서 이름 없음")
            }
        }
    }
    
    private var profileImageView: some View {
        ZStack {
            // 업로드된 프로필 이미지
            if let selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 55, height: 55)
                    .clipShape(Circle())
            } else {
                // 기본 아이콘
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 55, height: 55)
                    .foregroundStyle(Color("gray04"))
            }
        }
        .onLongPressGesture(minimumDuration: 1.0) {
            showImagePicker = true
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(images: $selectedImages, selectedLimit: 1)
        }
        .onChange(of: selectedImages) { oldValue, newValue in
            // 이미지가 선택되면 첫 번째 이미지만 유지
            if newValue.count > 1 {
                selectedImages = Array(newValue.prefix(1))
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(savedName + "님") // AppStorage에서 불러온 회원 이름
                    .font(.bold24)
                    .bold()
            }
            Text("WELCOME")
                .font(.medium14)
                .foregroundStyle(Color.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color("tag"))
                .cornerRadius(4)
            Spacer()
            Button(action: {
                router.push(.memberInfo)
            }) {
                Text("회원정보")
                    .font(.semiBold14)
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 11.5)
                    .padding(.vertical, 4)
                    .background(Color("gray07"))
                    .cornerRadius(14)
            }
        }
    }
    
    private var memberShipPointView: some View {
        HStack{
            Text("멤버십 포인트")
                .font(.semiBold14)
                .foregroundStyle(Color("gray04"))
            Text("포인트 값 입력")
            .font(.semiBold14)
            .foregroundStyle(Color.black)
            Spacer()
        }
    }
    
    private var clubMembershipButtonView: some View {
        HStack {
            
            Button(action: {}) {
                Text("클럽 멤버십")
                    .font(.semiBold16)
                Image(systemName: "chevron.right")
                    .foregroundStyle(.white)
            }
            .foregroundStyle(.white)
            .padding(.leading, 8)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(
                stops: [
                Gradient.Stop(color: Color(red: 0.67, green: 0.55, blue: 1), location: 0.00),
                Gradient.Stop(color: Color(red: 0.56, green: 0.68, blue: 0.95), location: 0.53),
                Gradient.Stop(color: Color(red: 0.36, green: 0.8, blue: 0.93), location: 1.00),
                ],
                startPoint: UnitPoint(x: 0, y: 0.5),
                endPoint: UnitPoint(x: 1, y: 0.5)
                )
            )
            .cornerRadius(8)
        }
    }
    
    private var myTicketView: some View {
        HStack {
            VStack {
                Text("쿠폰")
                    .font(.semiBold16)
                    .foregroundStyle(Color("gray02"))
                    .padding(.bottom, 5)
                Text("2")
                    .font(.semiBold18)
                    .foregroundStyle(Color.black)
            }
            Spacer()
            Divider()               // 구분선
                .foregroundStyle(Color("gray02"))
                .frame(width: 1, height: 31)
            Spacer()
            VStack {
                Text("스토어 교환권")
                    .font(.semiBold16)
                    .foregroundStyle(Color("gray02"))
                    .padding(.bottom, 5)
                Text("0")
                    .font(.semiBold18)
                    .foregroundStyle(Color.black)
            }
            Spacer()
            Divider()               // 구분선
                .foregroundStyle(Color("gray02"))
                .frame(width: 1, height: 31)
            Spacer()
            VStack {
                Text("모바일 티켓")
                    .font(.semiBold16)
                    .foregroundStyle(Color("gray02"))
                    .padding(.bottom, 5)
                Text("0")
                    .font(.semiBold18)
                    .foregroundStyle(Color.black)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 24)
        .background(){
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color("gray02"), lineWidth: 1)
        }
        
    }
    
    private var orderNavigatorView: some View {
        HStack {
            VStack {
                Image("film-reel")
                    .resizable()
                    .frame(width: 36, height: 36)
                    .padding(.bottom, 12)
                Text("영화관예매")
                    .font(.medium16)
                    .foregroundStyle(Color.black)
            }
            Spacer()
            VStack {
                Image("free-icon-pin-map")
                    .resizable()
                    .frame(width: 36, height: 36)
                    .padding(.bottom, 12)
                Text("극장별예매")
                    .font(.medium16)
                    .foregroundStyle(Color.black)
            }
            Spacer()
            VStack {
                Image("free-icon-sofa")
                    .resizable()
                    .frame(width: 36, height: 36)
                    .padding(.bottom, 12)
                Text("특별관예매")
                    .font(.medium16)
                    .foregroundStyle(Color.black)
            }
            Spacer()
            VStack {
                Image("free-icon-cinema")
                    .resizable()
                    .frame(width: 36, height: 36)
                    .padding(.bottom, 12)
                Text("모바일오더")
                    .font(.medium16)
                    .foregroundStyle(Color.black)
            }
        }
    }
}

#Preview {
    ProfileView()
}

#Preview("iPhone 11") {
    ProfileView()
}

#Preview("iPhone 16 Pro Max") {
    ProfileView()
}
