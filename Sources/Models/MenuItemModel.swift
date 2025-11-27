import SwiftUI

struct MenuItemModel: Identifiable, Hashable {
    struct Highlight: Identifiable, Hashable {
        let id = UUID()
        let icon: String
        let text: String
    }
    
    enum MenuCategory: String, CaseIterable, Identifiable {
        case combo = "콤보"
        case popcorn = "팝콘"
        case drink = "음료"
        case dessert = "디저트"
        case snack = "스낵"
        
        var id: String { rawValue }
        
        var emoji: String {
            switch self {
            case .combo: return "🥡"
            case .popcorn: return "🍿"
            case .drink: return "🥤"
            case .dessert: return "🧁"
            case .snack: return "🍪"
            }
        }
        
        var accentColor: Color {
            switch self {
            case .combo: return Color(red: 0.38, green: 0.27, blue: 0.92)
            case .popcorn: return Color(red: 0.96, green: 0.61, blue: 0.2)
            case .drink: return Color(red: 0.22, green: 0.62, blue: 0.94)
            case .dessert: return Color(red: 0.91, green: 0.36, blue: 0.58)
            case .snack: return Color(red: 0.26, green: 0.75, blue: 0.54)
            }
        }
    }
    
    let id = UUID()
    let category: MenuCategory
    let name: String
    let summary: String
    let detailDescription: String
    let price: Int
    let originalPrice: Int?
    let memberBenefit: String
    let heroImageName: String?
    let calories: Int?
    let sugar: Int?
    let caffeine: Int?
    let waitingTimeText: String
    let pickupInfoText: String
    let highlights: [Highlight]
    let isBest: Bool
    let isRecommended: Bool
    let discountRate: Int?
    let isSoldOut: Bool
    
    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: price)) ?? "\(price)"
    }
}

extension MenuItemModel {
    static let sampleItems: [MenuItemModel] = [

        MenuItemModel(
            category: .popcorn,
            name: "프리미엄 나쵸 세트",
            summary: "나쵸 + 치즈 + 탄산",
            detailDescription: "바삭한 나쵸와 더블 치즈 소스, 그리고 시원한 탄산을 한 번에. 든든하게 즐길 수 있는 조합이에요.",
            price: 9800,
            originalPrice: 11500,
            memberBenefit: "치즈 소스 리필 무료",
            heroImageName: nil,
            calories: 680,
            sugar: 12,
            caffeine: nil,
            waitingTimeText: "혼잡 시간대 약 8분",
            pickupInfoText: "테이크아웃 카운터",
            highlights: [
                Highlight(icon: "percent", text: "오늘만 15%"),
                Highlight(icon: "bolt", text: "단품도 가능")
            ],
            isBest: false,
            isRecommended: false,
            discountRate: 15,
            isSoldOut: true
        ),
        MenuItemModel(
            category: .drink,
            name: "시그니처 아이스티",
            summary: "히비스커스 & 베리 블렌딩",
            detailDescription: "메가박스 티소믈리에가 블렌딩한 산뜻한 아이스티. 은은한 히비스커스에 베리향을 더했습니다.",
            price: 6300,
            originalPrice: nil,
            memberBenefit: "2잔 구매 시 1천원 할인",
            heroImageName: nil,
            calories: 120,
            sugar: 18,
            caffeine: 15,
            waitingTimeText: "바로 제조되어요",
            pickupInfoText: "음료 스테이션",
            highlights: [
                Highlight(icon: "drop", text: "리필 가능"),
                Highlight(icon: "snowflake", text: "얼음 가득")
            ],
            isBest: false,
            isRecommended: true,
            discountRate: nil,
            isSoldOut: false
        ),
        MenuItemModel(
            category: .dessert,
            name: "미니 티라미수 컵",
            summary: "마스카포네 크림 층층이",
            detailDescription: "부드러운 마스카포네와 에스프레소 시럽을 겹겹이 쌓아 상영 전 달콤한 휴식을 선사합니다.",
            price: 7200,
            originalPrice: nil,
            memberBenefit: "디저트 2개 구매 시 10% 할인",
            heroImageName: nil,
            calories: 430,
            sugar: 32,
            caffeine: 25,
            waitingTimeText: "냉장 진열 즉시 수령",
            pickupInfoText: "디저트 냉장 쇼케이스",
            highlights: [
                Highlight(icon: "cup.and.saucer", text: "커피와 페어링"),
                Highlight(icon: "gift", text: "기프트 포장")
            ],
            isBest: false,
            isRecommended: false,
            discountRate: nil,
            isSoldOut: false
        )
    ]
}

extension MenuItemModel {
    static let detailPageItems: [MenuItemModel] = [
        MenuItemModel(
            category: .combo,
            name: "싱글 콤보",
            summary: "팝콘 + 탄산",
            detailDescription: "",
            price: 10900,
            originalPrice: nil,
            memberBenefit: "",
            heroImageName: "싱글 콤보",
            calories: nil,
            sugar: nil,
            caffeine: nil,
            waitingTimeText: "",
            pickupInfoText: "",
            highlights: [],
            isBest: true,
            isRecommended: false,
            discountRate: nil,
            isSoldOut: false
        ),
        MenuItemModel(
            category: .combo,
            name: "러브 콤보",
            summary: "팝콘 + 탄산",
            detailDescription: "",
            price: 10900,
            originalPrice: nil,
            memberBenefit: "",
            heroImageName: "러브 콤보",
            calories: nil,
            sugar: nil,
            caffeine: nil,
            waitingTimeText: "",
            pickupInfoText: "",
            highlights: [],
            isBest: true,
            isRecommended: false,
            discountRate: nil,
            isSoldOut: false
        ),
        MenuItemModel(
            category: .combo,
            name: "더블 콤보",
            summary: "팝콘 2 + 탄산",
            detailDescription: "",
            price: 24900,
            originalPrice: nil,
            memberBenefit: "",
            heroImageName: "더블 콤보",
            calories: nil,
            sugar: nil,
            caffeine: nil,
            waitingTimeText: "",
            pickupInfoText: "",
            highlights: [],
            isBest: true,
            isRecommended: false,
            discountRate: nil,
            isSoldOut: false
        ),
        MenuItemModel(
            category: .combo,
            name: "러브 콤보 패키지",
            summary: "스페셜 패키지",
            detailDescription: "",
            price: 32000,
            originalPrice: nil,
            memberBenefit: "",
            heroImageName: "러브 콤보 패키지",
            calories: nil,
            sugar: nil,
            caffeine: nil,
            waitingTimeText: "",
            pickupInfoText: "",
            highlights: [],
            isBest: true,
            isRecommended: false,
            discountRate: nil,
            isSoldOut: false
        ),
        MenuItemModel(
            category: .combo,
            name: "패밀리 콤보 패키지",
            summary: "패밀리 세트",
            detailDescription: "",
            price: 47000,
            originalPrice: nil,
            memberBenefit: "",
            heroImageName: "패밀리 콤보 패키지",
            calories: nil,
            sugar: nil,
            caffeine: nil,
            waitingTimeText: "",
            pickupInfoText: "",
            highlights: [],
            isBest: false,
            isRecommended: false,
            discountRate: nil,
            isSoldOut: false
        ),
        MenuItemModel(
            category: .snack,
            name: "메가박스 오리지널 티켓북 시즌4 돌비시네마 에디션 단품",
            summary: "시즌4 돌비 에디션",
            detailDescription: "",
            price: 10900,
            originalPrice: nil,
            memberBenefit: "",
            heroImageName: "메가박스 오리지널 티켓북 시즌4 돌비시네마 에디션 단품",
            calories: nil,
            sugar: nil,
            caffeine: nil,
            waitingTimeText: "",
            pickupInfoText: "",
            highlights: [],
            isBest: false,
            isRecommended: true,
            discountRate: nil,
            isSoldOut: false
        ),
        MenuItemModel(
            category: .snack,
            name: "디즈니 픽사 포스터",
            summary: "컬렉션 굿즈",
            detailDescription: "",
            price: 15900,
            originalPrice: nil,
            memberBenefit: "",
            heroImageName: "디즈니 픽사 포스터",
            calories: nil,
            sugar: nil,
            caffeine: nil,
            waitingTimeText: "",
            pickupInfoText: "",
            highlights: [],
            isBest: false,
            isRecommended: false,
            discountRate: nil,
            isSoldOut: true
        ),
        MenuItemModel(
            category: .snack,
            name: "인사이드아웃2 감정",
            summary: "리미티드 굿즈",
            detailDescription: "",
            price: 29900,
            originalPrice: 35900,
            memberBenefit: "",
            heroImageName: "인사이드아웃2 감정",
            calories: nil,
            sugar: nil,
            caffeine: nil,
            waitingTimeText: "",
            pickupInfoText: "",
            highlights: [],
            isBest: false,
            isRecommended: false,
            discountRate: 20,
            isSoldOut: false
        )
    ]
}

