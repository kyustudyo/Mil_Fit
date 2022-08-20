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


extension String {

    func String2DateType() -> Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: self)?.addingTimeInterval(60*60*9)
    }
    
    func String2DateTypeForWorkout() -> Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter.date(from: self)?.addingTimeInterval(60*60*9)
    }
    
    
//func toDateTime() -> Date {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd"
//    dateFormatter.timeZone = .current
//    dateFormatter.locale = .current
//    guard let date = dateFormatter.date(from: self) else {
//        preconditionFailure("Take a look to your format")
//    }
//    return date
//}
}
func getDayOfWeek(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEEEE"
    formatter.locale = Locale(identifier:"ko_KR")
    let convertStr = formatter.string(from: date)
    return convertStr
}
