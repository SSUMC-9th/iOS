import SwiftUI

struct OrderView: View {
    @State private var orderViewModel = OrderViewModel()
    @State private var selectedTheater: String = "강남"
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                ScrollView {
                    // 헤더 (극장 선택)
                    headerSection
                        .padding(.bottom, 26)
                    VStack(spacing: 15) {
                        // 바로 주문 및 카드 섹션
                        HStack(alignment: .top, spacing: 12) {
                            // 바로 주문 카드 (남은 공간 차지)
                            DirectOrderSectionView()
                                .frame(maxWidth: .infinity)
                                .frame(height: 308)
                            
                            // 오른쪽 카드들 (정사각형)
                            VStack(spacing: 12) {
                                StoreVoucherCardView()
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: 148)
                                
                                GiftCardView()
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: 148)
                            }
                        }
                        .frame(height: 308)
                        
                        // 어디서든 팝콘 만나기 섹션
                        DeliverySectionView()
                            .frame(height: 104)
                            .padding(.vertical, 5)
                            .padding(.bottom, 15)
                        
                        // 추천 메뉴 섹션
                        RecommendedMenuSectionView(menus: orderViewModel.recommendedMenus)
                            .padding(.bottom, 25)
                        
                        // 베스트 메뉴 섹션
                        BestMenuSectionView(menus: orderViewModel.bestMenus)
                            .padding(.bottom, 32)
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
    }
    
    private var headerSection: some View {
        VStack(spacing: 0) {
            // MEGABOX 로고
            HStack{
                Image("homeMegaboxLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 25)
                Spacer()
            }
            .padding(.leading, 16)
            .padding(.bottom, 17)
            .background(Color.white)
            
            // 극장 선택 바 (보라색 배경)
            TheaterChangeBarView(selectedTheater: selectedTheater) {
                // 극장 변경 액션
            }
        }
    }
}

#Preview {
    OrderView()
}

#Preview("iPhone 16 Pro Max") {
    OrderView()
}

