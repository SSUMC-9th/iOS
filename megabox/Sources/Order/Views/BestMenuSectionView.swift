import SwiftUI

struct BestMenuSectionView: View {
    let menus: [MenuItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("베스트 메뉴")
                    .font(.bold22)
                    .foregroundColor(.black)
                
                Text("영화 볼때 뭐먹지 고민될 때 베스트 메뉴!")
                    .font(.regular12)
                    .foregroundColor(Color("gray04"))
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
    BestMenuSectionView(menus: [
        MenuItem(name: "싱글 패키지", price: 8900, imageName: "single_package"),
        MenuItem(name: "러브 콤보 패키지", price: 19900, imageName: "love_combo_package"),
        MenuItem(name: "더블 패키지", price: 22900, imageName: "double_package")
    ])
    .padding()
}

