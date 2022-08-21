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
    static func deleteWorkoutData(name: String) {
        let realm = localRealm.objects(WorkoutRealm.self)
        let deleteTarget = realm.filter("name == '\(name)")
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
            
            let fitnessTest = FitnessTestRealm(date: date, testType: testType, level: level, isPracice: isPractice, count: count, minutes: minutes, seconds: seconds)
            try! localRealm.write({
                localRealm.add(fitnessTest)
            })
    }
        
    static func saveMealData(date: Date, mealTime: String, calories: Int, meals: [String]) {
        
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



