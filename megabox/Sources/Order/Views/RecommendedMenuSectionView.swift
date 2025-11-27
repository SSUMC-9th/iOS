import SwiftUI

struct RecommendedMenuSectionView: View {
    let menus: [MenuItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("추천 메뉴")
                    .font(.bold22)
                    .foregroundStyle(.black)
                
                Text("영화 볼때 뭐먹지 고민될 땐 추천 메뉴!")
                    .font(.regular12)
                    .foregroundStyle(Color("gray04"))
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 15) {
                    ForEach(menus) { menu in
                        MenuItemCardView(menuItem: menu)
                    }
                }
            }
        }
    }
}

#Preview {
    RecommendedMenuSectionView(menus: [
        MenuItem(name: "러브 콤보", price: 10900, imageName: "love_combo"),
        MenuItem(name: "더블 콤보", price: 24900, imageName: "double_combo"),
        MenuItem(name: "디즈니 픽사 콤보", price: 15900, imageName: "disney_pixar")
    ])
    .padding()
}

