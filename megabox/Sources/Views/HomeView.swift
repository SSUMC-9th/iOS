import SwiftUI


struct HomeView: View {
    var body: some View {
        
        ZStack {
            Color.white
                .ignoresSafeArea()   // 안전 영역(노치, 홈바 영역)까지 채우기
            VStack {
                Text("홈 화면")
            }
            .padding(.horizontal, 16)     // 좌우 여백
        }
        

    }
}

#Preview {
    HomeView()
}


#Preview("iPhone 11") {
    HomeView()
}

#Preview("iPhone 16 Pro Max") {
    HomeView()
}
