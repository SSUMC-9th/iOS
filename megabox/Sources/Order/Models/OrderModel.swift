import Foundation

struct MenuItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Int
    let imageName: String
    let isBest: Bool
    let isRecommended: Bool
    let isSoldOut: Bool
    let discountRate: Int? // 할인율 (예: 10, 20 등)
    let originalPrice: Int? // 원래 가격 (할인이 있는 경우)
    
    init(name: String, price: Int, imageName: String, isBest: Bool = false, isRecommended: Bool = false, isSoldOut: Bool = false, discountRate: Int? = nil, originalPrice: Int? = nil) {
        self.name = name
        self.price = price
        self.imageName = imageName
        self.isBest = isBest
        self.isRecommended = isRecommended
        self.isSoldOut = isSoldOut
        self.discountRate = discountRate
        self.originalPrice = originalPrice
    }
}

