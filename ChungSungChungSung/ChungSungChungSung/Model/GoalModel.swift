//
//  GoalsModel.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/14.
//

import Foundation
import CoreImage

struct GoalModel {
    var content: String
    var date: String
    var isAchieved: Bool
}

struct GoalData {
    var list = [
        GoalModel(content: "턱걸이 30개 하기", date: "2022.5.12", isAchieved: false),
        GoalModel(content: "쉬지 않고 30분 러닝하기", date: "2022.6.1", isAchieved: false),
        GoalModel(content: "윗몸일으키기 2분에 70개", date: "2022.6.15", isAchieved: false),
        GoalModel(content: "몸무게 00kg 되기", date: "2022.7.18", isAchieved: false),
        GoalModel(content: "일주일동안 운동 매일 하기", date: "2022.4.24", isAchieved: true)
    ]
}
