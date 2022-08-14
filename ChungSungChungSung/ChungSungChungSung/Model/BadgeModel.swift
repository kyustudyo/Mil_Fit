//
//  BadgeModel.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/14.
//

import Foundation

struct BadgeModel {
    var title: String
    var image: String
    var description: String
    var date: String?
}

struct BadgeData {
    var list = [
        BadgeModel(title: "우리의 시작", image: "firstStep", description: "군피트를 시작한 것을 환영합니다!", date: "2022.3.14"),
        BadgeModel(title: "첫 기록의 기쁨", image: "firstRecord", description: "첫 운동 기록을 추가했어요.", date: "2022.3.14"),
        BadgeModel(title: "일주일 연속 운동", image: "sevenDays", description: "일주일 동안 매일 운동을 기록했어요.", date: "2022.3.30"),
        BadgeModel(title: "한 달 연속 운동", image: "medal30Days", description: "한 달 동안 매일 운동을 기록했어요.", date: "2022.4.29"),
        BadgeModel(title: "체력검정 1급", image: "medal1Achiever", description: "체력검정 세 종목 모두 1급을 달성했어요.", date: "2022.6.25"),
        BadgeModel(title: "특급전사", image: "specialWarrior", description: "체력검정 세 종목 모두 특급을 달성했어요."),
        BadgeModel(title: "3km 달리기 특급", image: "running3km", description: "체력검정 3km 달리기 특급을 달성했어요."),
        BadgeModel(title: "팔굽혀펴기 특급", image: "pushUp", description: "체력검정 팔굽혀펴기 특급을 달성했어요.", date: "2022.7.17"),
        BadgeModel(title: "윗몸일으키기 특급", image: "sitUp", description: "체력검정 윗몸일으키기 특급을 달성했어요."),
        BadgeModel(title: "신기록 갱신", image: "newRecord", description: "체력검정에서 신기록을 처음 갱신했어요."),
        BadgeModel(title: "목표 10개 달성", image: "tenGoals", description: "설정한 목표 10개를 달성했어요."),
        BadgeModel(title: "목표 첫 달성", image: "firstGoal", description: "설정한 목표를 처음 달성했어요.", date: "2022.5.5"),
        BadgeModel(title: "칼로리 버닝", image: "calorieBurning", description: "하루 소비 칼로리가 섭취 칼로리를 처음 넘었어요!"),
        BadgeModel(title: "운동 컬렉터", image: "workoutCollector", description: "10가지 이상의 운동 기록을 추가했어요."),
        BadgeModel(title: "전역일 D-100", image: "hundred", description: "전역하기 전까지 꾸준히 같이 운동해요!")
    ]
}

