//
//  WorkoutModel.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/09.
//

import Foundation

struct WorkoutModel {
    var title: String
    var firstInputType: String?
    var secondInputType: String
    var isToday: Bool
    var isFavorite: Bool
}

struct WorkoutData {
    var list = [
        WorkoutModel(title: "푸시업", secondInputType: "회", isToday: true, isFavorite: true),
        WorkoutModel(title: "달리기", secondInputType: "분", isToday: true, isFavorite: true),
        WorkoutModel(title: "풀업", secondInputType: "회", isToday: true, isFavorite: true),
        WorkoutModel(title: "버피", secondInputType: "회", isToday: false, isFavorite: true),
        WorkoutModel(title: "싯업", secondInputType: "회", isToday: false, isFavorite: true),
        WorkoutModel(title: "벤치프레스", firstInputType: "KG", secondInputType: "회", isToday: false, isFavorite: true),
        WorkoutModel(title: "백스쿼트", firstInputType: "KG", secondInputType: "회", isToday: false, isFavorite: true),
        WorkoutModel(title: "레그 컬", firstInputType: "KG", secondInputType: "회", isToday: false, isFavorite: true),
        WorkoutModel(title: "덤벨 런지", firstInputType: "KG", secondInputType: "회", isToday: false, isFavorite: false),
        WorkoutModel(title: "레그 익스텐션", firstInputType: "KG", secondInputType: "회", isToday: false, isFavorite: false),
        WorkoutModel(title: "랫 풀 다운", firstInputType: "KG", secondInputType: "회", isToday: false, isFavorite: false),
        WorkoutModel(title: "체스트 프레스", firstInputType: "KG", secondInputType: "회", isToday: false, isFavorite: false),
        WorkoutModel(title: "트라이셉스 익스텐션", firstInputType: "KG", secondInputType: "회", isToday: false, isFavorite: false)
    ]
}

//struct WorkoutTemp {
//    var date: Date
//    var name: String
//    var set: Int
//    var count: Int?
//    var minutes: Int?
//    var seconds: Int?
//    var weight: Int?
//    var calories: Int?
//    var dateSorting: Int
//    var dateSearching: String
//}

//struct WorkoutTempData {
//
//}
