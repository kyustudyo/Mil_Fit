//
//  DataModel.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/15.
//

import Foundation

//식단 - 아침,점심,저녁
enum MealTime {
    case breakfast, lunch, dinner
}

enum TestList: String {
    case running = "3km 달리기"
    case pushup = "팔굽혀펴기"
    case situp = "윗몸일으키기"
}

enum TestLevel: String {
    case special = "특급"
    case first = "1급"
    case second = "2급"
    case third = "3급"
    case forth = "불합격"
}

//전체 데이터(매일매일 날짜별로 저장)
struct Daily {
    let date: Date
    var toDoList: [Todo]
    var meals: [Meal]
    var workoutData: [Workout]
    var fitnessTestData: [FitnessTest]
    var badges: [Badge]
    var totalInputCalories: Int
    var totalOutputCalories: Int = 0
    var weight: Double?
}

//목표
struct Todo {
    var content: String
    var isDone: Bool
}

//식단
struct Meal {
    let time: MealTime
    var menu: [String]
    let calories: Int
}

//운동데이터
struct Workout {
    let name: WorkOutList
    var set: Int = 1
    var count: Int?
    var minutes: Int?
    var seconds: Int?
    var weight: Int?
    var calories: Int?
}

//체력검정
struct FitnessTest {
    let testType: TestList
    var count: Int?
    var minutes: Int?
    var seconds: Int?
    var level: TestLevel
    var isPractice: Bool
}

//뱃지
struct Badge {
    let title: String //enum??
    let description: String
    let date: Date
}

extension Todo: Persistable {

    
    init(managedObject: RealmTodo) {
        self.content = managedObject.content
        self.isDone = managedObject.isDone
    }
    
    func managedObject() -> RealmTodo {
        let todo = RealmTodo()
        todo.content = self.content
        todo.isDone = self.isDone
        return todo
    }
}

