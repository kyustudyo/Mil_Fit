//
//  FitnessTestStandard.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/18.
//

import Foundation

public class FitnessTestStandard {
    static func calculateLevel(age: Int, type: String, count: Int?, minutes: Int?, seconds: Int?) -> String {
        var totalTime: Int = 0
        if minutes != nil && seconds != nil {
            totalTime = minutes! * 60 + seconds!
        }
        if type == "running" {
            if age < 26 {
                if totalTime <= 12 * 6 + 30 {
                    return "특급"
                }else if totalTime <= 13 * 6 + 32 {
                    return "1급"
                }else if totalTime <= 14 * 6 + 34 {
                    return "2급"
                }else if totalTime <= 15 * 6 + 36 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 31 {
                if totalTime <= 12 * 6 + 45 {
                    return "특급"
                }else if totalTime <= 13 * 6 + 52 {
                    return "1급"
                }else if totalTime <= 14 * 6 + 59 {
                    return "2급"
                }else if totalTime <= 16 * 6 + 6 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 36 {
                if totalTime <= 13 * 6 {
                    return "특급"
                }else if totalTime <= 14 * 6 + 12 {
                    return "1급"
                }else if totalTime <= 15 * 6 + 24 {
                    return "2급"
                }else if totalTime <= 16 * 6 + 36 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 41 {
                if totalTime <= 13 * 6 + 15 {
                    return "특급"
                }else if totalTime <= 14 * 6 + 32 {
                    return "1급"
                }else if totalTime <= 15 * 6 + 49 {
                    return "2급"
                }else if totalTime <= 17 * 6 + 6 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 44 {
                if totalTime <= 13 * 6 + 30 {
                    return "특급"
                }else if totalTime <= 14 * 6 + 49 {
                    return "1급"
                }else if totalTime <= 16 * 6 + 7 {
                    return "2급"
                }else if totalTime <= 17 * 6 + 26 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 47 {
                if totalTime <= 13 * 6 + 45 {
                    return "특급"
                }else if totalTime <= 15 * 6 + 5 {
                    return "1급"
                }else if totalTime <= 16 * 6 + 26 {
                    return "2급"
                }else if totalTime <= 17 * 6 + 46 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 50 {
                if totalTime <= 14 * 6 {
                    return "특급"
                }else if totalTime <= 15 * 6 + 25 {
                    return "1급"
                }else if totalTime <= 16 * 6 + 51 {
                    return "2급"
                }else if totalTime <= 18 * 6 + 16 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 52 {
                if totalTime <= 14 * 6 + 15 {
                    return "특급"
                }else if totalTime <= 15 * 6 + 42 {
                    return "1급"
                }else if totalTime <= 17 * 6 + 9 {
                    return "2급"
                }else if totalTime <= 18 * 6 + 36 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 54 {
                if totalTime <= 14 * 6 + 30 {
                    return "특급"
                }else if totalTime <= 16 * 6 + 2 {
                    return "1급"
                }else if totalTime <= 17 * 6 + 34 {
                    return "2급"
                }else if totalTime <= 19 * 6 + 6 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 56 {
                if totalTime <= 14 * 6 + 45 {
                    return "특급"
                }else if totalTime <= 16 * 6 + 19 {
                    return "1급"
                }else if totalTime <= 17 * 6 + 52 {
                    return "2급"
                }else if totalTime <= 19 * 6 + 26 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 58 {
                if totalTime <= 15 * 6 + 10 {
                    return "특급"
                }else if totalTime <= 16 * 6 + 46 {
                    return "1급"
                }else if totalTime <= 18 * 6 + 23 {
                    return "2급"
                }else if totalTime <= 19 * 6 + 59 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 60 {
                if totalTime <= 15 * 6 + 35 {
                    return "특급"
                }else if totalTime <= 17 * 6 + 13 {
                    return "1급"
                }else if totalTime <= 18 * 6 + 51 {
                    return "2급"
                }else if totalTime <= 20 * 6 + 29 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else {
                if totalTime <= 16 * 6 {
                    return "특급"
                }else if totalTime <= 17 * 6 + 40 {
                    return "1급"
                }else if totalTime <= 19 * 6 + 19 {
                    return "2급"
                }else if totalTime <= 20 * 6 + 59 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }
        }else if type == "pushup" {
            guard let count = count else {
                return "불합격"
            }
            if age < 26 {
                if count >= 72 {
                    return "특급"
                }else if count >= 64 {
                    return "1급"
                }else if count >= 56 {
                    return "2급"
                }else if count >= 48 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 31 {
                if count >= 70 {
                    return "특급"
                }else if count >= 62 {
                    return "1급"
                }else if count >= 54 {
                    return "2급"
                }else if count >= 46 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 36 {
                if count >= 68 {
                    return "특급"
                }else if count >= 60 {
                    return "1급"
                }else if count >= 52 {
                    return "2급"
                }else if count >= 44 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 41 {
                if count >= 65 {
                    return "특급"
                }else if count >= 57 {
                    return "1급"
                }else if count >= 49 {
                    return "2급"
                }else if count >= 41 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 44 {
                if count >= 61 {
                    return "특급"
                }else if count >= 53 {
                    return "1급"
                }else if count >= 45 {
                    return "2급"
                }else if count >= 37 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 47 {
                if count >= 57 {
                    return "특급"
                }else if count >= 49 {
                    return "1급"
                }else if count >= 41 {
                    return "2급"
                }else if count >= 33 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 50 {
                if count >= 54 {
                    return "특급"
                }else if count >= 46 {
                    return "1급"
                }else if count >= 38 {
                    return "2급"
                }else if count >= 30 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 52 {
                if count >= 51 {
                    return "특급"
                }else if count >= 43 {
                    return "1급"
                }else if count >= 35 {
                    return "2급"
                }else if count >= 27 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 54 {
                if count >= 49 {
                    return "특급"
                }else if count >= 41 {
                    return "1급"
                }else if count >= 33 {
                    return "2급"
                }else if count >= 25 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 56 {
                if count >= 47 {
                    return "특급"
                }else if count >= 39 {
                    return "1급"
                }else if count >= 31 {
                    return "2급"
                }else if count >= 23 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 58 {
                if count >= 44 {
                    return "특급"
                }else if count >= 36 {
                    return "1급"
                }else if count >= 28 {
                    return "2급"
                }else if count >= 20 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 60 {
                if count >= 42 {
                    return "특급"
                }else if count >= 34 {
                    return "1급"
                }else if count >= 26 {
                    return "2급"
                }else if count >= 18 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else {
                if count >= 40 {
                    return "특급"
                }else if count >= 32 {
                    return "1급"
                }else if count >= 24 {
                    return "2급"
                }else if count >= 16 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }
        }else {
            guard let count = count else {
                return "불합격"
            }
            if age < 26 {
                if count >= 86 {
                    return "특급"
                }else if count >= 78 {
                    return "1급"
                }else if count >= 70 {
                    return "2급"
                }else if count >= 62 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 31 {
                if count >= 84 {
                    return "특급"
                }else if count >= 76 {
                    return "1급"
                }else if count >= 68 {
                    return "2급"
                }else if count >= 60 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 36 {
                if count >= 80 {
                    return "특급"
                }else if count >= 72 {
                    return "1급"
                }else if count >= 65 {
                    return "2급"
                }else if count >= 57 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 41 {
                if count >= 76 {
                    return "특급"
                }else if count >= 68 {
                    return "1급"
                }else if count >= 60 {
                    return "2급"
                }else if count >= 52 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 44 {
                if count >= 72 {
                    return "특급"
                }else if count >= 64 {
                    return "1급"
                }else if count >= 56 {
                    return "2급"
                }else if count >= 48 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 47 {
                if count >= 68 {
                    return "특급"
                }else if count >= 60 {
                    return "1급"
                }else if count >= 52 {
                    return "2급"
                }else if count >= 44 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 50 {
                if count >= 65 {
                    return "특급"
                }else if count >= 57 {
                    return "1급"
                }else if count >= 49 {
                    return "2급"
                }else if count >= 41 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 52 {
                if count >= 62 {
                    return "특급"
                }else if count >= 54 {
                    return "1급"
                }else if count >= 46 {
                    return "2급"
                }else if count >= 38 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 54 {
                if count >= 60 {
                    return "특급"
                }else if count >= 52 {
                    return "1급"
                }else if count >= 44 {
                    return "2급"
                }else if count >= 36 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 56 {
                if count >= 58 {
                    return "특급"
                }else if count >= 48 {
                    return "1급"
                }else if count >= 40 {
                    return "2급"
                }else if count >= 32 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 58 {
                if count >= 56 {
                    return "특급"
                }else if count >= 48 {
                    return "1급"
                }else if count >= 40 {
                    return "2급"
                }else if count >= 32 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else if age < 60 {
                if count >= 54 {
                    return "특급"
                }else if count >= 46 {
                    return "1급"
                }else if count >= 38 {
                    return "2급"
                }else if count >= 30 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }else {
                if count >= 52 {
                    return "특급"
                }else if count >= 44 {
                    return "1급"
                }else if count >= 36 {
                    return "2급"
                }else if count >= 28 {
                    return "3급"
                }else {
                    return "불합격"
                }
            }
        }
    }
}
