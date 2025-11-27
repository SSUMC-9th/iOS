import SwiftUI

@Observable
class OrderViewModel {
    var recommendedMenus: [MenuItem] = [
        MenuItem(name: "러브 콤보", price: 10900, imageName: "love_combo"),
        MenuItem(name: "더블 콤보", price: 24900, imageName: "double_combo"),
        MenuItem(name: "디즈니 픽사 포스터", price: 15900, imageName: "disney_pixar")
    ]
    
    var bestMenus: [MenuItem] = [
        MenuItem(name: "싱글 패키지", price: 8900, imageName: "single_package"),
        MenuItem(name: "더블 콤보", price: 24900, imageName: "double_combo"),
        MenuItem(name: "러브 콤보 패키지", price: 32000, imageName: "love_combo_package")
    ]
    
    var allMenus: [MenuItem] = [
        MenuItem(name: "싱글 콤보", price: 10900, imageName: "single_combo", isBest: true),
        MenuItem(name: "러브 콤보", price: 10900, imageName: "love_combo", isBest: true),
        MenuItem(name: "더블 콤보", price: 24900, imageName: "double_combo", isBest: true),
        MenuItem(name: "러브 콤보 패키지", price: 32000, imageName: "love_combo_package"),
        MenuItem(name: "패밀리 콤보 패키지", price: 47000, imageName: "family_combo_package"),
        MenuItem(name: "메가박스 오리지널 티켓북 시즌4 돌비", price: 10900, imageName: "ticket_book", isRecommended: true),
        MenuItem(name: "디즈니 픽사 포스터", price: 15900, imageName: "disney_pixar", isSoldOut: true),
        MenuItem(name: "인사이드아웃2 감정", price: 29900, imageName: "inside_out", originalPrice: 35900)
    ]
}

