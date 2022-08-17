//
//  Webservice.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/17.
//

import Foundation
import FSCalendar
class keyValues {
    
    static let ids = ["3932313635323235383532323032313430","3133313635303732333032353832313337","3036313631323236383432323032313039"]

    static func getId() -> String {
        ids.randomElement() ?? ""
    }
    
}

class Webservice {
    
    let totalArmy = ["제5322부대", "제6282부대", "제8623부대", "제7369부대", "제8902부대", "제9030부대", "제5021부대", "제8623부대", "제3389부대", "제1691부대", "제2171부대", "제3296부대", "제6335부대", "제1575부대", "제2291부대", "제3182부대", "제2621부대", "제5397부대", "제7162부대", "제3296부대", "제6176부대", "제1862부대", "없음"]
    
    static let shared = Webservice()
    
    private init() { }
    
    func fetchMeals300(army: String) {
        print((String(Array(army)[1..<5])))
        let armyNumber = (String(Array(army)[1..<5]))
        let url: URL = URL(string: "https://openapi.mnd.go.kr/\(keyValues.getId())/json/DS_TB_MNDT_DATEBYMLSVC_\(String(Array(army)[1..<5]))/1/10000/")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
//              print(String(decoding: data, as: UTF8.self))
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
//                let 오늘식단 = army.mealInfo?.rows?.filter{$0.dates == dateformatter.string(from: Date())}//실무
//                guard let 매일매일 = army.mealInfo?.rows else { return }
                
                let 많은날짜 = army.mealInfo?.rows
                
//                let 오늘날짜 = dateformatter.string(from: Date())
                let 앞으로30일뒤Date = Calendar.current.date(byAdding: .day, value: 30, to: Date()) ?? Date()
                let 앞으로30일전Date = Calendar.current.date(byAdding: .day, value: -30, to: Date()) ?? Date()
                
//                let 앞으로30일뒤String = dateformatter.string(from: 앞으로30일뒤Date)
//                let 앞으로30일전String = dateformatter.string(from: 앞으로30일전Date)
                
                
                var current = 앞으로30일전Date
                
                
                while 앞으로30일전Date < 앞으로30일뒤Date {
                    if let 오늘식단 = army.mealInfo?.rows?.filter{$0.dates == dateformatter.string(from: current)} {
                        
                        let date = 오늘식단.compactMap { meals in
                            return meals.dates?.toDate()
                        }
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
                        print(current)
                        RealmManager.saveMealData(date: date[0], mealTime: "조식", calories: 총칼로리[0], meals: 아침들)
                        RealmManager.saveMealData(date: date[0], mealTime: "중식", calories: 총칼로리[0], meals: 점심들)
                        RealmManager.saveMealData(date: date[0], mealTime: "석식", calories: 총칼로리[0], meals: 저녁들)
                        current = CalendarHelper().addDays(date: current, days: 1)
                    }
                }
                
                
                
               
                
//                print("점심:", 점심들 ?? [])
//                print("저녁:", 저녁들 ?? [])
//                if let 총칼 = 총칼로리{
//                    print("칼로리:", 총칼.count != 0 ? 총칼[0] : "개수 0 입니다.")
//                } else {
//                    print("칼로리 제공 안합니다.")
//                }
//                print("-------------------")
            }
        }.resume()
        
    }

    
    
    
    func abc() { }
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

extension String {
    func toDate() -> Date? { //"yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
