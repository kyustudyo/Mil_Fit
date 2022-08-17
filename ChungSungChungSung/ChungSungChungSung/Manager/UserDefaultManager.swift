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


