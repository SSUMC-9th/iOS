//
//  Utils.swift
//  mega
//
//  Created by 이경민 on 10/27/25.
//

import Foundation

extension Date {
    func isSameDay(as other: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: other)
    }

    func dayOfMonth() -> String {
        let f = DateFormatter()
        f.dateFormat = "d"
        return f.string(from: self)
    }

    /// index=0: "오늘", 1: "내일", 그 외 요일 약어(월~일)
    func weekdayString(for index: Int) -> String {
        if index == 0 { return "오늘" }
        if index == 1 { return "내일" }
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_KR")
        f.dateFormat = "E"
        return f.string(from: self)
    }
}
