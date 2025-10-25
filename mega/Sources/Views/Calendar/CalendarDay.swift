//
//  CalendarDay.swift
//  mega
//
//  Created by 이경민 on 10/6/25.
//

import Foundation

struct CalendarDay: Identifiable {
    var id: UUID = .init()
    let day: Int
    let date: Date
    let isCurrentMonth: Bool
}
