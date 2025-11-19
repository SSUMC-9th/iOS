import SwiftUI

enum TheaterBarStyle {
    case purple  // 보라색 배경, 흰색 텍스트
    case white   // 흰색 배경, 검은색 텍스트, 보라색 버튼
}

struct TheaterChangeBarView: View {
    let selectedTheater: String
    let onChangeTheater: () -> Void
    let style: TheaterBarStyle
    
    init(selectedTheater: String, onChangeTheater: @escaping () -> Void, style: TheaterBarStyle = .purple) {
        self.selectedTheater = selectedTheater
        self.onChangeTheater = onChangeTheater
        self.style = style
    }
    
    var body: some View {
        HStack {
            // 왼쪽: 위치 아이콘과 극장명
            HStack(spacing: 8) {
                Image(systemName: "mappin.circle.fill")
                    .foregroundColor(style == .purple ? .white : .black)
                    .font(.system(size: 16))
                
                Text(selectedTheater)
                    .font(.semiBold13)
                    .foregroundStyle(style == .purple ? Color.white : Color.black)
            }
            
            Spacer()
            
            // 오른쪽: 극장 변경 버튼
            Button {
                onChangeTheater()
            } label: {
                Text("극장 변경")
                    .font(.semiBold13)
                    .foregroundColor(style == .purple ? .white : Color("purple03"))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(style == .purple ? Color.white : Color("gray02"), lineWidth: 1)
                    )
            }
        }
        .padding(.horizontal, style == .purple ? 20 : 16)
        .padding(.vertical, 10)
        .background(style == .purple ? Color("purple03") : Color.white)
    }
}

#Preview("Purple Style") {
    TheaterChangeBarView(selectedTheater: "강남", style: .purple) {
        print("극장 변경")
    }
}

#Preview("White Style") {
    TheaterChangeBarView(selectedTheater: "강남", style: .white) {
        print("극장 변경")
    }
}

