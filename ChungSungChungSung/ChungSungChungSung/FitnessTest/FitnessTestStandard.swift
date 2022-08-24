//
//  FitnessTestStandard.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/18.
//

import Foundation

enum TestAge {
    case one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen
    init?(age: Int) {
        switch age {
        case 0..<26: self = .one
        case 26..<31: self = .two
        case 31..<36: self = .three
        case 36..<41: self = .four
        case 41..<44: self = .five
        case 44..<47: self = .six
        case 47..<50: self = .seven
        case 50..<52: self = .eight
        case 52..<54: self = .nine
        case 54..<56: self = .ten
        case 56..<58: self = .eleven
        case 58..<60: self = .twelve
        case 60..<99: self = .thirteen
        case _: return nil
        }
    }
}

enum TestType: String {
    case running = "3km 달리기"
    case pushup = "팔굽혀펴기(2분)"
    case situp = "윗몸일으키기"
}

struct FitnessTest {
    let type: TestType
    let standard: [String : (Int, Int)]
}


let testStandard: [TestAge: [FitnessTest]] = [
    .one: [FitnessTest(type: .running, standard: ["특급" : (0, 12 * 60 + 30), "1급" : (12 * 60 + 31, 13 * 60 + 32), "2급" : (13 * 60 + 33, 14 * 60 + 34), "3급" : (14 * 60 + 35, 15 * 60 + 36), "불합격" : (15 * 60 + 37, 180 * 60)]), FitnessTest(type: .pushup, standard: ["특급" : (72,999), "1급" : (64, 71), "2급" : (56,63), "3급" : (48,55), "불합격" : (0, 47)]), FitnessTest(type: .situp, standard: ["특급": (86,999), "1급" : (78, 85), "2급" : (70,77), "3급" : (62, 69), "불합격" : (0,61)])],
        .two: [FitnessTest(type: .running, standard: ["특급" : (1, 12 * 60 + 45), "1급" : (12 * 60 + 46, 13 * 60 + 52), "2급" : (13 * 60 + 53, 14 * 60 + 59), "3급" : (15 * 60, 16 * 60 + 6), "불합격" : (16 * 60 + 7, 180 * 60)]), FitnessTest(type: .pushup, standard: ["특급" : (70, 999), "1급" : (62, 69), "2급" : (54, 61), "3급" : (46, 53), "불합격" : (0, 45)]), FitnessTest(type: .situp, standard: ["특급" : (84, 999), "1급" : (76, 83), "2급" : (68, 75), "3급" : (60, 67), "불합격" : (0, 59)])],
        .three: [FitnessTest(type: .running, standard: ["특급" : (1, 13 * 60), "1급" : (13 * 60 + 1, 14 * 60 + 12), "2급" : (14 * 60 + 13, 15 * 60 + 24), "3급" : (15 * 60 + 25, 16 * 60 + 36), "불합격" : (16 * 60 + 37, 180 * 60)]), FitnessTest(type: .pushup, standard: ["특급" : (68, 999), "1급" : (60, 67), "2급" : (52, 59), "3급" : (44, 51), "불합격" : (0, 43)]), FitnessTest(type: .situp, standard: ["특급" : (80, 999), "1급" : (72, 79), "2급" : (65, 71), "3급" : (57, 64), "불합격" : (0, 56)])],
        .four: [FitnessTest(type: .running, standard: ["특급" : (1, 13 * 60 + 15), "1급" : (13 * 60 + 16, 14 * 60 + 32), "2급" : (14 * 60 + 33, 15 * 60 + 49), "3급" : (15 * 60 + 50, 17 * 60 + 6), "불합격" : (17 * 60 + 7, 180 * 60)]), FitnessTest(type: .pushup, standard: ["특급" : (65, 999), "1급" : (57, 64), "2급" : (49, 56), "3급" : (41, 48), "불합격" : (0, 40)]), FitnessTest(type: .situp, standard: ["특급" : (76, 999), "1급" : (68, 75), "2급" : (60, 67), "3급" : (52, 59), "불합격" : (0, 51)])],
        .five: [FitnessTest(type: .running, standard: ["특급" : (1, 13 * 60 + 30), "1급" : (13 * 60 + 31, 14 * 60 + 49), "2급" : (14 * 60 + 50, 16 * 60 + 7), "3급" : (16 * 60 + 8, 17 * 60 + 26), "불합격" : (17 * 60 + 27, 180 * 60)]), FitnessTest(type: .pushup, standard: ["특급" : (61, 999), "1급" : (53, 60), "2급" : (45, 52), "3급" : (37, 44), "불합격" : (0, 36)]), FitnessTest(type: .situp, standard: ["특급" : (72, 999), "1급" : (64, 71), "2급" : (56, 63), "3급" : (48, 55), "불합격" : (0, 47)])],
        .six: [
            FitnessTest(type: .running, standard: [
                "특급" : (1, 13 * 60 + 45),
                "1급" : (13 * 60 + 36, 15 * 60 + 5),
                "2급" : (15 * 60 + 6, 16 * 60 + 26),
                "3급" : (16 * 60 + 27, 17 * 60 + 46),
                "불합격" : (17 * 60 + 47, 180 * 60)]),
            FitnessTest(type: .pushup, standard: ["특급" : (57, 999), "1급" : (49, 56), "2급" : (41, 48), "3급" : (33, 40), "불합격" : (0, 32)]),
            FitnessTest(type: .situp, standard: ["특급" : (68, 999), "1급" : (60, 67), "2급" : (52, 59), "3급" : (44, 51), "불합격" : (0, 43)])
        ],
        .seven: [FitnessTest(type: .running, standard: ["특급" : (1, 14 * 60), "1급" : (14 * 60 + 1, 15 * 60 + 25), "2급" : (15 * 60 + 26, 16 * 60 + 51), "3급" : (16 * 60 + 52, 18 * 60 + 16), "불합격" : (18 * 60 + 17, 180 * 60)]), FitnessTest(type: .pushup, standard: ["특급" : (54, 999), "1급" : (46, 53), "2급" : (38, 45), "3급" : (30, 37), "불합격" : (0, 29)]), FitnessTest(type: .situp, standard: ["특급" : (65, 999), "1급" : (57, 64), "2급" : (49, 56), "3급" : (41, 48), "불합격" : (0, 40)])],
        .eight: [FitnessTest(type: .running, standard: ["특급" : (1, 14 * 60 + 15), "1급" : (14 * 60 + 16, 15 * 60 + 42), "2급" : (15 * 60 + 43, 17 * 60 + 9), "3급" : (17 * 60 + 10, 18 * 60 + 36), "불합격" : (18 * 60 + 37, 180 * 60)]), FitnessTest(type: .pushup, standard: ["특급" : (51, 999), "1급" : (43, 50), "2급" : (35, 42), "3급" : (27, 34), "불합격" : (0, 26)]), FitnessTest(type: .situp, standard: ["특급" : (62, 999), "1급" : (54, 61), "2급" : (46, 53), "3급" : (38, 45), "불합격" : (0, 37)])],
        .nine: [FitnessTest(type: .running, standard: ["특급" : (1, 14 * 60 + 30), "1급" : (14 * 60 + 31, 16 * 60 + 2), "2급" : (16 * 60 + 3, 17 * 60 + 34), "3급" : (17 * 60 + 35, 19 * 60 + 6), "불합격" : (19 * 60 + 7, 180 * 60)]), FitnessTest(type: .pushup, standard: ["특급" : (49, 999), "1급" : (41, 48), "2급" : (33, 40), "3급" : (25, 32), "불합격" : (0, 24)]), FitnessTest(type: .situp, standard: ["특급" : (60, 999), "1급" : (52, 59), "2급" : (44, 51), "3급" : (36, 43), "불합격" : (0, 35)])],
        .ten: [FitnessTest(type: .running, standard: ["특급" : (1, 14 * 60 + 45), "1급" : (14 * 60 + 46, 16 * 60 + 19), "2급" : (16 * 60 + 20, 17 * 60 + 52), "3급" : (17 * 60 + 53, 19 * 60 + 26), "불합격" : (19 * 60 + 27, 180 * 60)]), FitnessTest(type: .pushup, standard: ["특급" : (47, 999), "1급" : (39, 46), "2급" : (31, 38), "3급" : (23, 30), "불합격" : (0, 22)]), FitnessTest(type: .situp, standard: ["특급" : (58, 999), "1급" : (50, 57), "2급" : (42, 49), "3급" : (34, 41), "불합격" : (0, 33)])],
        .eleven: [FitnessTest(type: .running, standard: ["특급" : (1, 15 * 60 + 10), "1급" : (15 * 60 + 11, 16 * 60 + 47), "2급" : (16 * 60 + 47, 18 * 60 + 23), "3급" : (18 * 60 + 24, 19 * 60 + 59), "불합격" : (20 * 60, 180 * 60)]), FitnessTest(type: .pushup, standard: ["특급" : (44, 999), "1급" : (36, 43), "2급" : (28, 35), "3급" : (20, 27), "불합격" : (0, 19)]), FitnessTest(type: .situp, standard: ["특급" : (56, 999), "1급" : (48, 55), "2급" : (40, 47), "3급" : (32, 39), "불합격" : (0, 31)])],
        .twelve: [FitnessTest(type: .running, standard: ["특급" : (1, 15 * 60 + 35), "1급" : (15 * 60 + 36, 17 * 60 + 13), "2급" : (17 * 60 + 14, 18 * 60 + 51), "3급" : (18 * 60 + 52, 20 * 60 + 29), "불합격" : (20 * 60 + 30, 180 * 60)]), FitnessTest(type: .pushup, standard: ["특급" : (42, 999), "1급" : (34, 41), "2급" : (26, 33), "3급" : (18, 25), "불합격" : (0, 17)]), FitnessTest(type: .situp, standard: ["특급" : (54, 999), "1급" : (46, 53), "2급" : (38, 45), "3급" : (30, 37), "불합격" : (0, 29)])],
        .thirteen: [FitnessTest(type: .running, standard: ["특급" : (1, 16 * 60), "1급" : (16 * 60 + 1, 17 * 60 + 40), "2급" : (17 * 60 + 41, 19 * 60 + 19), "3급" : (19 * 60 + 20, 20 * 60 + 59), "불합격" : (21 * 60, 180 * 60)]), FitnessTest(type: .pushup, standard: ["특급" : (40, 999), "1급" : (32, 39), "2급" : (24, 31), "3급" : (16, 23), "불합격" : (0, 15)]), FitnessTest(type: .situp, standard: ["특급" : (52, 999), "1급" : (44, 51), "2급" : (36, 43), "3급" : (28, 35), "불합격" : (0, 27)])]]

func calculateLevel(testType: TestType, minutes: Int?, seconds: Int?, count: Int?) -> String {
    print(#function)
    let age = UserDefaults.standard.integer(forKey: "age")
    var totalTime = 0
    var counts = 0
    if minutes != nil && seconds != nil {
        totalTime = minutes! * 60 + seconds!
    }
    if count != nil {
        counts = count!
    }
    let testAge = TestAge(age: age)!
    let testAll = testStandard[testAge]!
    for i in testAll {
       if i.type == testType {
           for (key, value) in i.standard {
               if i.type == .running {
                   if totalTime >= value.0 && totalTime <= value.1 {
                       return key
                   }
               }else {
                   if counts >= value.0 && counts <= value.1 {
                       return key
                   }
               }
           }
        }
    }
    return "없음"
}

func getMaxStandard(testType: TestType, level: String) -> Int {
    let age = UserDefaults.standard.integer(forKey: "age")
    let testAge = TestAge(age: age)!
    let testAll = testStandard[testAge]!
    for i in testAll {
       if i.type == testType {
           for (key, value) in i.standard {
               if key == level {
                   return value.1
               }
           }
        }
    }
    return 0
}

func getMinStandard(testType: TestType, level: String) -> Int {
    let age = UserDefaults.standard.integer(forKey: "age")
    let testAge = TestAge(age: age)!
    let testAll = testStandard[testAge]!
    for i in testAll {
       if i.type == testType {
           for (key, value) in i.standard {
               if key == level {
                   return value.0
               }
           }
        }
    }
    return 0
}
