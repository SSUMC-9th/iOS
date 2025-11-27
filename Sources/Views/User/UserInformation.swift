import SwiftUI
import UIKit

// MARK: - Image Picker Wrapper
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.isPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
}

struct UserInformation: View {
    
    @EnvironmentObject var viewModel: LoginViewModel
    @State private var profileImage: UIImage? = nil
    @State private var showImagePicker: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    // Profile Section with Profile Image
                    HStack(spacing: 12) {
                        // Profile Image
                        ZStack {
                            if let profileImage = profileImage {
                                Image(uiImage: profileImage)
                                    .resizable()
                                    .scaledToFill()
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(Color("gray02"))
                            }
                        }
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())
                        .onLongPressGesture(minimumDuration: 1.0) {
                            showImagePicker = true
                        }
                        
                        // User Info Section
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Text("\(viewModel.userName)" + "님")
                                    .font(.bold24)
                                
                                Spacer()
                                
                                Text("Welcome")
                                    .font(.medium14)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color("tag"))
                                    .cornerRadius(6)
                                
                                Spacer()
                                    .frame(minWidth: 135)
                                
                                NavigationLink(destination: Text("회원정보 관리 뷰")) {
                                    Text("회원정보")
                                        .font(.semiBold14)
                                        .foregroundStyle(.white)
                                        .frame(width: 64, height: 20)
                                        .padding(.vertical, 4)
                                        .padding(.horizontal, 4)
                                        .background(Color("gray07"))
                                        .cornerRadius(16)
                                        .padding(.trailing, 16)
                                }
                            }
                            
                            HStack {
                                Text("멤버쉽 포인트")
                                    .font(.semiBold14)
                                    .foregroundStyle(Color("gray04"))
                                
                                Text("500P")
                                    .font(.medium14)
                                    .padding(.leading, 9)
                                
                                Spacer()
                            }
                            .padding(.top, 12)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 59)
                    .padding(.bottom, 10)
                    
                    Button(action: {
                         
                    }) {
                        HStack {
                            Text("클럽 멤버쉽")
                                .font(.semiBold16)
                             
                            Image("arrow")
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                        .padding(.vertical, 12)
                        .background(
                            LinearGradient (
                                gradient: Gradient(colors: [
                                    Color(hex: "#AB8BFF"),
                                    Color(hex: "#8EAEF3"),
                                    Color(hex: "#5DCCEC")
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing)
                        )
                        .cornerRadius(8)
                    }
                    .padding(.top, 15)
                    .padding(.horizontal, 15)
                    .padding(.bottom, 33)
                     
                    HStack {
                        VStack {
                            Text("쿠폰")
                                .font(.semiBold16)
                                .foregroundStyle(Color("gray02"))
                            Text("2")
                                .font(.semiBold18)
                        }
                         
                        Rectangle()
                            .foregroundColor(Color("gray02"))
                            .frame(width: 1, height: 31)
                            .padding(.horizontal, 20)
                         
                        VStack {
                            Text("스토어 교환권")
                                .font(.semiBold16)
                                .foregroundStyle(Color("gray02"))
                            Text("0")
                                .font(.semiBold18)
                        }
                         
                        Rectangle()
                            .foregroundColor(Color("gray02"))
                            .frame(width: 1, height: 31)
                            .padding(.horizontal, 20)
                         
                        VStack {
                            Text("모바일 티켓")
                                .font(.semiBold16)
                                .foregroundStyle(Color("gray02"))
                            Text("0")
                                .font(.semiBold18)
                        }
                    }
                    .frame(width: 362, height: 52)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(Color("gray02")), lineWidth: 1)
                    )
                    .padding(.bottom, 33)
                     
                    HStack {
                        VStack {
                            Image("film_reel")
                            Text("영화별 예매")
                                .font(.medium16)
                        }
                        .padding(.leading, 16)
                        Spacer()
                         
                        VStack {
                            Image("pin_map")
                            Text("극장별 예매")
                                .font(.medium16)
                        }
                         
                        Spacer()
                         
                        VStack {
                            Image("sofa")
                            Text("특별관 예매")
                                .font(.medium16)
                        }
                         
                        Spacer()
                         
                        VStack {
                            Image("popcorn")
                            Text("모바일오더")
                                .font(.medium16)
                        }
                        .padding(.trailing, 16)
                    }
                    
                    // [수정] 로그아웃 버튼 추가
                    Button(action: {
                        // 뷰모델의 로그아웃 함수를 호출합니다.
                        viewModel.handleLogout()
                    }) {
                        Text("로그아웃")
                            .font(.semiBold16)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color.red) // 로그아웃 버튼
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 15)
                    .padding(.top, 33) // 위 요소와의 간격
                    .padding(.bottom, 50) // 하단 여백
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $profileImage, isPresented: $showImagePicker)
            }
        }
    }
}


extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#") // # 문자 제거
         
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb) // 16진수를 정수로 변환
         
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
         
        self.init(red: r, green: g, blue: b)
    }
}


#Preview {
    UserInformation()
        .environmentObject(LoginViewModel())
}
