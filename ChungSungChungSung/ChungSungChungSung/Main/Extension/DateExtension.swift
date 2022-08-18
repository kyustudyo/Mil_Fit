//
//  DateExtension.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/18.
//

import Foundation

extension Date {
    func formatterAppliedString() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        dateformatter.locale = Locale(identifier: "ko_KR")
        return dateformatter.string(from: self)
    }
}
