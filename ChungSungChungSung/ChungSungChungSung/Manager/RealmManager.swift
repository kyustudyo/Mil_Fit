//
//  RealmManager.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/17.
//

import Foundation
import RealmSwift

public class RealmManager {
    
    static let localRealm = try! Realm()
    
    static func saveTodoListData(date: Date, content: String, isDone: Bool) {
        
        let toDoList = ToDoListRealm(content: content, isDone: isDone, date: date)
        try! localRealm.write {
            localRealm.add(toDoList)
        }
    }
    static func saveWorkoutData(date: Date, name: String, set: Int = 1, count: Int?, minutes: Int?, seconds: Int?, weight: Int?, calories: Int?) {
        
        let workOut = WorkoutRealm(date: date, name: name, set: set, count: count, minutes: minutes, seconds: seconds, weight: weight, calories: calories)
        try! localRealm.write({
            localRealm.add(workOut)
        })
    }
    
    //오늘 한 운동 삭제시
    static func deleteWorkoutData(name: String, selectedDate: String) {
        let realm = localRealm.objects(WorkoutRealm.self)
        let deleteTarget = realm.where {
            $0.name == name && $0.dateSearching == selectedDate
        }
        try! localRealm.write({
            localRealm.delete(deleteTarget)
        })
    }
    
    //오늘 한 운동 추가/편집시
    static func editWorkoutData(name: String, set: Int?, count: Int?, minutes: Int?, seconds: Int?, weight: Int?, calories: Int? ) {
        let realm = localRealm.objects(WorkoutRealm.self)
        let updateTarget = realm.filter("name == '\(name)'").first!
        try! localRealm.write({
            updateTarget.set = set ?? 1
            updateTarget.count = count
            updateTarget.minutes = minutes
            updateTarget.seconds = seconds
            updateTarget.weight = weight
            updateTarget.calories = calories
        })
    }
    
    //날짜별 운동데이터 가져올때
    static func searchWorkoutDataByDate(date: String) -> Results<WorkoutRealm> {
        let realm = localRealm.objects(WorkoutRealm.self)
        let target = realm.filter("dateSearching == '\(date)'")
        return target
    }

    static func saveFitnessTestData(date: Date, testType: String, count: Int?, minutes:Int?, seconds: Int?, level: String, isPractice: Bool) {
            
            let fitnessTest = FitnessTestRealm(date: date, testType: testType, level: level, isPractice: isPractice, count: count, minutes: minutes, seconds: seconds)
            try! localRealm.write({
                localRealm.add(fitnessTest)
            })
    }
        
    static func saveMealData(date: String, mealTime: String, calories: Int, meals: [String]) {
        let localRealm = try! Realm()
        let mealList = MealRealm(date: date, mealTime: mealTime, calories: calories)
        mealList.mealArray = meals
        try! localRealm.write({
            localRealm.add(mealList)
        })
    }
    
    static func saveTotalInputCaloriesData(date: Date, calories: Int) {
        
        let inputCalories = TotalInputCaloriesRealm(date: date, calories: calories)
        
        try! localRealm.write({
            localRealm.add(inputCalories)
        })
    }
    
    static func saveTotalOutputCaloriesData(date: Date, calories: Int) {
        
        let outputCalories = TotalOutputCaloriesRealm(date: date, calories: calories)
        
        try! localRealm.write({
            localRealm.add(outputCalories)
        })
    }
    
    static func saveWeightData(date: Date, weight: Int) {
        
        let weight = WeightRealm(date: date, weight: weight)
        
        try! localRealm.write({
            localRealm.add(weight)
        })
    }
    
    static func saveBadgeData(date: Date, title: String) {
        
        let badge = BadgeRealm(title: title, date: date)
        
        try! localRealm.write({
            localRealm.add(badge)
        })
    }
}

extension RealmManager {
    
    
    
//    static func saveTodoListData(date: Date, content: String, isDone: Bool) {
//
//        let toDoList = ToDoListRealm(content: content, isDone: isDone, date: date)
//        try! localRealm.write {
//            localRealm.add(toDoList)
//        }
//    }
    //workout
    static func fetchSearchDidWorkoutDates() -> [Date]? {
        let localRealm = try! Realm()
        let dates = Array(localRealm.objects(WorkoutRealm.self)
            .map { workoutRealm in
                workoutRealm.date
            })
        if dates.count == 0 {
            return nil
        } else {
            return dates
        }
//            .map { $0.date }
            
    }
    
    static func searchWorkoutDataByDateK(date: String) -> Results<WorkoutRealm>? {
        let realm = localRealm.objects(WorkoutRealm.self)
        let target = realm.filter("dateSearching == '\(date)'")
        if target.count == 0 {
            return nil
        } else {
            return target
        }
    }
    
    static func deleteAllWorkoutData() {
        
        let localRealm = try! Realm()
        let alls = localRealm.objects(WorkoutRealm.self)
        try! localRealm.write {
            localRealm.delete(alls)
        }
    }
    
    static func fetchWorkOutDataByDate(date: String) -> Results<WorkoutRealm>? {
        let localRealm = try! Realm()
        let realm = localRealm.objects(WorkoutRealm.self)
        let target = realm.filter("dateSearching == '\(date)'")
        if target.count == 0 {
            return nil
        } else {
            return target
        }
    }
    
    //tododata
    static func notDoneTodoData() -> Results<ToDoListRealm>? {
        let localRealm = try! Realm()
        let realm = localRealm.objects(ToDoListRealm.self)
                            .filter("isDone = false")
                            .sorted(byKeyPath: "dateSorting", ascending: false)
        if realm.count == 0 {
            return nil
        } else {
            return realm
        }
    }
    
    static func todoDoneAt(_ id: Int) {
        print(id)
        let localRealm = try! Realm()
        let todoDone = localRealm.objects(ToDoListRealm.self)
                            .filter("dateSorting == %@", id)
                            .first
        try! localRealm.write {
            todoDone?.isDone.toggle()
        }
    }
    
    static func deleteAlTodosData() {
        
        let localRealm = try! Realm()
        let alls = localRealm.objects(ToDoListRealm.self)
        try! localRealm.write {
            localRealm.delete(alls)
        }
    }
    
    //meal
    static func deleteAllMealsData() {
        
        let localRealm = try! Realm()
        let alls = localRealm.objects(MealRealm.self)
        try! localRealm.write {
            localRealm.delete(alls)
        }
    }
    
    static func allMealData() -> Results<MealRealm>? {
        let localRealm = try! Realm()
        let realm = localRealm.objects(MealRealm.self)
        if realm.count == 0 {
            return nil
        } else {
            return realm
        }
       
    }
    
    static func searchMealDataByDate(date: String) -> Results<MealRealm>? {
        let localRealm = try! Realm()
        let realm = localRealm.objects(MealRealm.self)
//        print(date)
        let target = realm.filter("date == '\(date)'")
        if target.count == 0 {
            return nil
        } else {
            return target
        }
    }
    
//    static func searchMealDataByDate(dates: [String]) -> Results<MealRealm>? {
//        let localRealm = try! Realm()
//        let realm = localRealm.objects(MealRealm.self)
////        print(date)
//        var results: Results<MealRealm>?
//        
//    }
    
    //몸무게
    
    static func searchCurrentWeight() -> Int? {
        let localRealm = try! Realm()
        let realm = localRealm.objects(WeightRealm.self)
        let target = realm.sorted(byKeyPath: "dateSorting", ascending: false)
        if target.count == 0 {
            return nil
        } else {
            return target[0].weight
        }
    }
    static func deleteAllWeightData() {
        
        let localRealm = try! Realm()
        let alls = localRealm.objects(WeightRealm.self)
        try! localRealm.write {
            localRealm.delete(alls)
        }
    }
    
    
}

