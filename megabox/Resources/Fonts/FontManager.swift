//
//  FontManager.swift
//  megabox
//
//  Created by 문인성 on 9/24/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretend {
        case extraBold
        case bold
        case semiBold
        case regular
        case medium
        case light
        
        var value: String {
            switch self {
            case .extraBold:
                return "Pretendard-ExtraBold"
            case .bold:
                return "Pretendard-Bold"
            case .semiBold:
                return "Pretendard-semiBold"
            case .medium:
                return "Pretendard-Medium"
            case .regular:
                return "Pretendard-Regular"
            case .light:
                return "Pretendard-Light"
            }
        }
    }
    
    static func pretend(type: Pretend, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    static var extraBold24: Font {
        return .pretend(type: .extraBold, size: 24)
    }
    
    static var bold18: Font {
        return .pretend(type: .bold, size: 18)
    }
    
    static var bold22: Font {
        return .pretend(type: .bold, size: 22)
    }
    
    static var bold24: Font {
        return .pretend(type: .bold, size: 24)
    }
    
    static var semiBold12: Font {
        return .pretend(type: .semiBold, size: 12)
    }
    
    static var semiBold13: Font {
        return .pretend(type: .semiBold, size: 13)
    }
    
    static var semiBold14: Font {
        return .pretend(type: .semiBold, size: 14)
    }
    
    static var semiBold16: Font {
        return .pretend(type: .semiBold, size: 16)
    }
    
    static var semiBold18: Font {
        return .pretend(type: .semiBold, size: 18)
    }
    
    static var semiBold24: Font {
        return .pretend(type: .semiBold, size: 24)
    }
    
    static var semiBold38: Font {
        return .pretend(type: .semiBold, size: 38)
    }
    
    static var regular09: Font {
        return .pretend(type: .regular, size: 09)
    }
    
    static var regular12: Font {
        return .pretend(type: .regular, size: 12)
    }
    
    static var regular13: Font {
        return .pretend(type: .regular, size: 13)
    }
    
    static var regular18: Font {
        return .pretend(type: .regular, size: 18)
    }
    
    static var regular20: Font {
        return .pretend(type: .regular, size: 20)
    }
    
    static var medium08: Font {
        return .pretend(type: .medium, size: 08)
    }
    
    static var medium10: Font {
        return .pretend(type: .medium, size: 10)
    }
    
    static var medium13: Font {
        return .pretend(type: .medium, size: 13)
    }
    
    static var medium14: Font {
        return .pretend(type: .medium, size: 14)
    }
    
    static var medium16: Font {
        return .pretend(type: .medium, size: 16)
    }
    
    static var medium18: Font {
        return .pretend(type: .medium, size: 18)
    }
    
    static var light14: Font {
        return .pretend(type: .light, size: 14)
    }
}
