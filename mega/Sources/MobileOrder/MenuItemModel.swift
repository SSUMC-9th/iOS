//
//  MenuItemModel.swift
//  mega
//
//  Created by 이경민 on 11/17/25.
//

import Foundation
import SwiftUI

struct MenuItemModel: Identifiable {
    let id = UUID()
    let title: String
    let price: Int
    let imageName: String
    
    // 상태 관련
    let isBest: Bool?
    let isRecommended: Bool?
    let isSoldOut: Bool
    let discountRate: Int?
}
