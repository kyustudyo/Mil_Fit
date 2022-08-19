//
//  UserDefaultManager.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/17.
//

import Foundation

public class UserDefaultManager {
    
    static func saveDischargeDate(date: Date) {
        UserDefaults.standard.set(date, forKey: "dischargeDate")
    }
    
    static func saveUnit(unit: String) {
        UserDefaults.standard.set(unit, forKey: "unit")
    }
    
    static func saveAge(age: Int) {
        UserDefaults.standard.set(age, forKey: "age")
    }
    
    static func saveBMR(BMR: Int) {
        UserDefaults.standard.set(BMR, forKey: "BMR")
    }
    
    static func saveHeight(height: Int) {
        UserDefaults.standard.set(height, forKey: "height")
    }
    
    static func saveIsWorkoutDate(date: String) {
        let defaults = UserDefaults.standard
        
        if defaults.stringArray(forKey: "workoutDate") == nil {
            defaults.set([date], forKey: "workoutDate")
        }else {
            guard var dates = defaults.stringArray(forKey: "workoutDate") else { return () }
            dates.append(date)
            defaults.set(dates, forKey: "workoutDate")
        }
    }
}


extension UserDefaultManager {
    static func loadDischargeDate() -> Date? {
        guard let date = UserDefaults.standard.object(forKey: "dischargeDate") as? Date else {
            return nil
        }
        return date
    }
    
    static func saveStartDate(date: Date) {
        UserDefaults.standard.set(date, forKey: "firstDayOfTheApp")
    }
    
    static func loadStartDate() -> Date? {
        guard let date = UserDefaults.standard.object(forKey: "firstDayOfTheApp") as? Date else {
            return nil
        }
        return date
    }
    
    static func isFirstTimeComleted() -> Bool {
        if let _ = UserDefaults.standard.object(forKey: "firstComplete") as? Bool {
            return true
        } else {
            UserDefaults.standard.set(true, forKey: "firstComplete")
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "yyyy-MM-dd"
            print(Date().addingTimeInterval(60*60*9))
            
            
            UserDefaults.standard.set(Date().addingTimeInterval(60*60*9), forKey: "firstDayOfTheApp")
            return false
        }
    }
    
    
    static func loadBMR() -> Int? {
        guard let bmr = UserDefaults.standard.object(forKey: "BMR") as? Int else {
            return nil
        }
        return bmr
    }
    
    static func loadHeight() -> Int? {
        guard let bmr = UserDefaults.standard.object(forKey: "height") as? Int else {
            return nil
        }
        return bmr
    }
    
    static func removeFirstTimeExperience()  {
        UserDefaults.standard.removeObject(forKey: "firstComplete")
    }
}
