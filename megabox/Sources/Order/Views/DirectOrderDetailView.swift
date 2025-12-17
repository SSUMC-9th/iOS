import SwiftUI

struct DirectOrderDetailView: View {
    @EnvironmentObject var router: NavigationRouter
    @State private var orderViewModel = OrderViewModel()
    @State private var selectedTheater: String = "강남"
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 상단 헤더
                headerView
                
                ScrollView {
                    VStack(spacing: 16) {
                        // 메뉴 그리드
                        menuGridSection
                            .padding(.top, 16)
                            .padding(.bottom, 32)
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var headerView: some View {
        VStack(spacing: 0) {
            // 상단 바 (뒤로가기, 타이틀, 장바구니)
            HStack {
                // 뒤로가기 버튼
                Button {
                    router.pop()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                        .font(.system(size: 18, weight: .medium))
                }
                
                // 타이틀
                Text("바로주문")
                    .font(.semiBold18)
                    .foregroundStyle(.black)
                
                Spacer()
                
                // 장바구니 아이콘
                Button {
                    // 장바구니 액션
                } label: {
                    Image(systemName: "cart")
                        .foregroundStyle(.black)
                        .font(.system(size: 20))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            
            // 극장 선택 바 (흰색 배경)
            TheaterChangeBarView(selectedTheater: selectedTheater, onChangeTheater: {
                // 극장 변경 액션
            }, style: .white)
            
            // 구분선
            Divider()
                .background(Color("gray02"))
        }
    }
    
    private var menuGridSection: some View {
        let columns = [
            GridItem(.flexible(), spacing: 12),
            GridItem(.flexible(), spacing: 12)
        ]
        
        return LazyVGrid(columns: columns, spacing: 20) {
            ForEach(orderViewModel.allMenus) { menu in
                MenuItemCardView(menuItem: menu)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DirectOrderDetailView()
            .environmentObject(NavigationRouter())
    }
}

