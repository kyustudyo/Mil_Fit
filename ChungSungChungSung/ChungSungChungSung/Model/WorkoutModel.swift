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
}

struct WorkoutData {
    var list = [
        WorkoutModel(title: "푸시업", secondInputType: "회"),
        WorkoutModel(title: "달리기", secondInputType: "분"),
        WorkoutModel(title: "풀업", secondInputType: "회")
    ]
}
