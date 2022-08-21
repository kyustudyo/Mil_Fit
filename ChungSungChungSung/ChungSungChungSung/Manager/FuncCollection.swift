//
//  FuncCollection.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/17.
//

import Foundation
import RealmSwift

//date -> Int ex. 20220817131031
func dateToSortDate(date: Date) -> Int {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMddHHmmss"
    dateFormatter.locale = Locale(identifier: "ko_KR")
    let convertInt = Int(dateFormatter.string(from: date))
    if let convertInt = convertInt {
        return convertInt
    }else {
        return -1
    }
}


//미완성
func isToday(_ date: Date) -> Bool {

    let now = Date() // 현재의 Date (ex: 2020-08-13 09:14:48 +0000)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd-EEE"// 2020-08-13 16:30
    var str = dateFormatter.string(from: now)// 현재 시간의 Date를 format에 맞춰 string으로 반환
    let defaults = UserDefaults.standard
    if defaults.object(forKey: "date") == nil {
        UserDefaults.standard.set(str, forKey: "date")
        UserDefaults.standard.set(now, forKey: "Date")
        return true
    } else {
        var date = UserDefaults.standard.string(forKey: "date")!
        let tmpDate = date.split(separator: "-").map{String($0)}
        let tmpStr = str.split(separator: "-").map{String($0)}
        date = "\(tmpDate[0])-\(tmpDate[1])-\(tmpDate[2])"
        str = "\(tmpStr[0])-\(tmpStr[1])-\(tmpStr[2])"

        if date == str {
            return true
        }else {
            return false
        }
    }
}

func isValidNumber(_ text: String?) -> Int {

    guard let text = text else {
        return ErrorString.EmptyString.rawValue
    }
    
    if text.isEmpty { return ErrorString.EmptyString.rawValue}
    if Int(text) == nil { return ErrorString.NotNumber.rawValue}
    else if Int(text) == 0 { return ErrorString.Zero.rawValue}
    return 0
}
