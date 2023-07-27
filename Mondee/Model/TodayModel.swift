//
//  TodayModel.swift
//  Mondee
//
//  Created by Seokmin on 2023/07/25.
//

import Foundation

enum GameStatus {
    case notStarted
    case inProgress
    case paused
    case finishedSuccess
    case finishedFail
}

struct Level {
    let name: String
    let startNumber: Int
    let endNumber: Int
    let mondeeImg: String
    let nextLevelMessage: String
}

struct LevelInfo : Identifiable {
    let id = UUID()
    let mondeeImg: String
    let mondeeTitle: String
    let mondeeContents: String
}

let cleanMondeeLines = [
    "🤤 후 물맛 좋네",
    "😋 77ㅓ억~",
    "♨️ 사실 더 지지고싶었어",
    "💧 이집 물 맛집이네",
    "🛁 여기 물이 좋다니까",
    "🥸 왜 계속 찔러 너 나 좋아해?",
    "✨ 청소 좀 치는데?"
]

let dirtyMondeeLines = [
    "🚿 시원~하게 등목 때리고싶자너",
    "🧼 나도 씻겨줘잉",
    "🙃 오늘은 청소.. 할거지?",
    "🧽 청소 갈겨~~ 샤워 갈겨~~",
    "🤔 누가 샤워 안시켜주나?ㅎ",
    "🩹 반창고? 눈썹 잘못 깎았어",
    "🥸 왜 계속 찔러 너 나 좋아해?"
]
