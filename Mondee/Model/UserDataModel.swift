//
//  SampleModel.swift
//  Mondee
//
//  Created by hyunjun on 2023/07/12.
//

import Foundation
import SwiftUI

// MARK: Data Manager

/// User 구조체 생성
struct User: Codable, Identifiable {
    var id = UUID()
    // var gameData: [String]
    var gameSuccess: Bool
    var gameFail: Bool
    var gamePlayTime: Int
    var gamePlayDate: Date
    var remainingHeartCount: Int
    var gameRetry: Bool
    var gameStart: Bool
    var gamePause: Bool
}


struct MondeeLog: Codable {
    let mondee: Mondee
    let date: Date
}

/// 클래스 생성
class UserData: ObservableObject {
    
    @Published var userdata: [User] = []
    
    /// 데이터 업로드
    init() {
        loadData()
    }
    
    /// 데이터 save
    func save(_ gameSuccess: Bool, _ gameFail: Bool, _ gamePlayTime: Int, _ gamePlayDate: Date, _ remainingHeartCount : Int, _ gameRetry : Bool, _ gameStart: Bool, _ gamePause: Bool) {
        let newData = User(gameSuccess: gameSuccess, gameFail: gameFail, gamePlayTime: gamePlayTime, gamePlayDate: gamePlayDate, remainingHeartCount: remainingHeartCount, gameRetry: gameRetry, gameStart: gameStart, gamePause: gamePause)
        userdata.append(newData)
        saveData()
    }
    
    /// 데이터 delete
    func delete(at index: Int) {
        userdata.remove(at: index)
        saveData()
    }
    
    /// 객체를 JSON 형식으로 인코딩하여 UserDefaults에 저장
    /// User 타입의 객체 배열을 저장하기 위함
    private func saveData() {
        if let encodedData = try? JSONEncoder().encode(userdata) {
            UserDefaults.standard.set(encodedData, forKey: "userData")
            loadData()
        }
    }
    
    /// UserDefaults에서 "userData"라는 키를 사용하여 데이터를 로드하고, 이를 JSON 디코딩하여 User 타입의 객체 배열로 디코딩
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "userData") {
            if let decodedData = try? JSONDecoder().decode([User].self, from: data) {
                userdata = decodedData
            }
        }
    }
    
    func generateRandomDateInJuly() -> Date {
         let calendar = Calendar.current
         let month = 7 // July
         let year = calendar.component(.year, from: Date())
         let dayRange = calendar.range(of: .day, in: .month, for: Date())!
         let randomDay = Int.random(in: dayRange.lowerBound..<dayRange.upperBound)
         
         var components = DateComponents()
         components.year = year
         components.month = month
         components.day = randomDay
         
         return calendar.date(from: components) ?? Date()
     }
}


class MondeeLogData: ObservableObject {
    @Published var mondeeLog: [MondeeLog] = []
    
    /// 데이터 업로드
    init() {
        loadData()
    }
    
    /// 데이터 save
    func save(_ mondee: Mondee, _ date: Date) {
        let newData = MondeeLog(mondee: mondee, date: date)
        mondeeLog.append(newData)
        saveData()
    }
    
    /// 데이터 delete
    func delete(at index: Int) {
        mondeeLog.remove(at: index)
        saveData()
    }
    
    private func saveData() {
        if let encodedData = try? JSONEncoder().encode(mondeeLog) {
            UserDefaults.standard.set(encodedData, forKey: "mondeeLogData")
            loadData()
        }
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "mondeeLogData") {
            if let decodedData = try? JSONDecoder().decode([MondeeLog].self, from: data) {
                mondeeLog = decodedData
            }
        }
    }
}
