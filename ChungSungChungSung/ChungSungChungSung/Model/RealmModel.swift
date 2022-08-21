//
//  RealmModel.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/17.
//

import Foundation
import RealmSwift

class ToDoListRealm: Object {
    @Persisted var content: String
    @Persisted var isDone: Bool
    @Persisted var date: Date
    @Persisted var dateSorting: Int
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(content: String, isDone: Bool, date: Date) {
        self.init()
        self.content = content
        self.isDone = isDone
        self.date = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let convertInt = Int(dateFormatter.string(from: date))
        if let convertInt = convertInt {
            self.dateSorting = convertInt
        }else {
            self.dateSorting = -1
        }
    }
}

class WorkoutRealm: Object {
    @Persisted var date: Date
    @Persisted var name: String
    @Persisted var set: Int
    @Persisted var count: Int?
    @Persisted var minutes: Int?
    @Persisted var seconds: Int?
    @Persisted var weight: Int?
    @Persisted var calories: Int?
    @Persisted var dateSorting: Int
    @Persisted var dateSearching: String

    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(date: Date, name: String, set: Int = 1, count: Int? = nil, minutes: Int? = nil, seconds: Int? = nil, weight: Int? = nil, calories: Int? = nil) {
        self.init()
        self.date = date
        self.name = name
        self.set = set
        self.count = count
        self.minutes = minutes
        self.seconds = seconds
        self.weight = weight
        self.calories = calories
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let convertInt = Int(dateFormatter.string(from: date))
        if let convertInt = convertInt {
            self.dateSorting = convertInt
        }else {
            self.dateSorting = -1
        }
        dateFormatter.dateFormat = "yyyyMMdd"
        dateSearching = dateFormatter.string(from: date)
    }
}

class FitnessTestRealm: Object {
    @Persisted var date: Date
    @Persisted var testType: String
    @Persisted var count: Int?
    @Persisted var minutes: Int?
    @Persisted var seconds: Int?
    @Persisted var level: String
    @Persisted var isPractice: Bool
    @Persisted var dateSorting: Int
    @Persisted var totalTime: Int?

    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(date: Date, testType: String, level: String, isPracice: Bool, count: Int? = nil, minutes: Int? = nil, seconds: Int? = nil) {
        self.init()
        self.date = date
        self.testType = testType
        self.level = level
        self.isPractice = isPractice
        self.count = count
        self.minutes = minutes
        self.seconds = seconds
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let convertInt = Int(dateFormatter.string(from: date))
        if let convertInt = convertInt {
            self.dateSorting = convertInt
        }else {
            self.dateSorting = -1
        }
        if (minutes != nil) && (seconds != nil) {
            self.totalTime = minutes! * 60 + seconds!
        }
        
    }
    
}

class MealRealm: Object {
    @Persisted var date: Date
    @Persisted var mealTime: String
    @Persisted var calories: Int
    let mealList: List<String> = List<String>()
    var mealArray: [String] {
        get {
            return mealList.map{$0}
        }
        set {
            mealList.removeAll()
            mealList.append(objectsIn: newValue)
        }
    }
    
    @Persisted(primaryKey: true) var _id: ObjectId
    convenience init(date: Date, mealTime: String, calories: Int) {
        self.init()
        self.date = date
        self.mealTime = mealTime
        self.calories = calories
    }
}

class TotalInputCaloriesRealm: Object {
    @Persisted var date: Date
    @Persisted var calories: Int
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(date: Date, calories: Int) {
        self.init()
        self.date = date
        self.calories = calories
    }
}

class TotalOutputCaloriesRealm: Object {
    @Persisted var date: Date
    @Persisted var calories: Int
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(date: Date, calories: Int) {
        self.init()
        self.date = date
        self.calories = calories
    }
}

class WeightRealm: Object {
    @Persisted var date: Date
    @Persisted var weight: Int
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(date: Date, weight: Int) {
        self.init()
        self.weight = weight
    }
}

class BadgeRealm: Object {
    @Persisted var title: String
    @Persisted var date: Date
    @Persisted var dateSorting: Int
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(title: String, date: Date) {
        self.init()
        self.title = title
        self.date = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let convertInt = Int(dateFormatter.string(from: date))
        if let convertInt = convertInt {
            self.dateSorting = convertInt
        }else {
            self.dateSorting = -1
        }
    }
}
