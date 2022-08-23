//
//  Webservice.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/17.
//

import Foundation
import FSCalendar
class keyValues {
    
    static let ids = ["3932313635323235383532323032313430","3133313635303732333032353832313337","3036313631323236383432323032313039", "3839313636363331343832323732303937"]

    static func getId() -> String {
        ids.randomElement() ?? ""
    }
    
}

class Webservice {
    
    let totalArmy = ["제5322부대", "제6282부대", "제8623부대", "제7369부대", "제8902부대", "제9030부대", "제5021부대", "제8623부대", "제3389부대", "제1691부대", "제2171부대", "제3296부대", "제6335부대", "제1575부대", "제2291부대", "제3182부대", "제2621부대", "제5397부대", "제7162부대", "제3296부대", "제6176부대", "제1862부대", "없음"]
    
    static let shared = Webservice()
    
    private init() { }
    
    func fetchMeals300(army: String, completion: @escaping () -> () ) {
        guard army != "없음" && army != "" else {
            DispatchQueue.main.async {
                RealmManager.deleteAllMealsData()
                completion()
            }
            return
        }
        let key = keyValues.getId()
        let url: URL = URL(string: "https://openapi.mnd.go.kr/\(key)/json/DS_TB_MNDT_DATEBYMLSVC_\(String(Array(army)[1..<5]))/1/10000/")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            RealmManager.deleteAllMealsData()
            if let data = data {
                print("dddd", String(data: data, encoding: .utf8))
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .custom { keys in
                    if keys.count == 1 {
                        return AnyKey(stringValue: "mealInfo")!
                    } else {
                        return AnyKey(stringValue: keys.last!.stringValue)!
                    }
                }
                guard let army = try? decoder.decode(MealResponse.self, from: data) else {
                    return
                }
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = "yyyy-MM-dd"
                dateformatter.locale = Locale(identifier: "ko_KR")
    
                
                let 앞으로15일뒤Date = Calendar.current.date(byAdding: .day, value: 15, to: Date()) ?? Date()
                let 앞으로15일전Date = Calendar.current.date(byAdding: .day, value: -15, to: Date()) ?? Date()
                var current = 앞으로15일전Date
                while current < 앞으로15일뒤Date {
                    if let 오늘식단 = army.mealInfo?.rows?.filter{$0.dates == dateformatter.string(from: current)} {
                        let date = 오늘식단.compactMap { meals in
                            return meals.dates
                        }
                        current = CalendarHelper().addDays(date: current, days: 1)
                        guard !date.isEmpty else { continue }
                        let 아침들 = 오늘식단.compactMap { meals in
                            meals.brst?.components(separatedBy: "(")[0]
                        }
                        let 점심들 = 오늘식단.compactMap { meals in
                            meals.lunc?.components(separatedBy: "(")[0]
                        }
                        let 저녁들 = 오늘식단.compactMap { meals in
                            meals.dinr?.components(separatedBy: "(")[0]
                        }
                        let 총칼로리 = 오늘식단.compactMap { mealRow -> Int in
                            let calString = mealRow.sum_cal?.replacingOccurrences(of: "kcal", with: "") ?? "0"
                            let slicedString = calString.components(separatedBy: ".")[0]
                            return Int(slicedString) ?? 0
                        }
                        
                        RealmManager.saveMealData(date: date[0], mealTime: "조식", calories: 총칼로리[0], meals: 아침들)
                        RealmManager.saveMealData(date: date[0], mealTime: "중식", calories: 총칼로리[0], meals: 점심들)
                        RealmManager.saveMealData(date: date[0], mealTime: "석식", calories: 총칼로리[0], meals: 저녁들)
                    
                        
                        
                    }
                }
                completion()
            }
        }.resume()
    }
}

// 식단 API 모델

struct MealResponse: Codable {
    let mealInfo: MealInfo?
}

struct MealInfo: Codable {
    let rows: [MealRow]?

    enum CodingKeys: String, CodingKey {
        case rows = "row"
    }
}

struct MealRow: Codable {
    let sum_cal: String?
    let dates: String?
    let lunc, brst, dinr: String?
}

struct DecodingStrategy {
    static var mealInfo: ([CodingKey]) -> CodingKey {
        return { keys -> CodingKey in
            return AnyKey(stringValue: "mealInfoqwer")!
        }
    }
}

struct AnyKey: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }
    
    init?(intValue: Int) {
        self.stringValue = String(intValue)
        self.intValue = intValue
    }
}


//    func toDate() -> Date? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        dateFormatter.locale = Locale.current
//        dateFormatter.timeZone = TimeZone.current
//
//        if let date = dateFormatter.date(from: self) {
//            return date
//        } else {
//            return nil
//        }
//    }
func geToDate2(strDate: String) -> Date {
    let df = DateFormatter()
    df.locale = Locale(identifier: "ko_KR")
    df.timeZone = TimeZone(abbreviation: "KST")
    df.dateFormat = "yyyy-MM-dd"
    return df.date(from: strDate)!
}




