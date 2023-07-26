//
//  TodayModel.swift
//  Mondee
//
//  Created by Seokmin on 2023/07/25.
//

import Foundation

struct Level {
    let name: String
    let startNumber: Int
    let endNumber: Int
    let mondeeImg: String
    let nextLevelMessage: String
}

let dirtyMondeeLines = [
    "🚿 시원~하게 등목 때리고싶자너",
    "🧼 나도 씻겨줘잉",
    "🙃 오늘은 청소.. 할거지?",
    "🧽 청소 갈겨~~ 샤워 갈겨~~",
    "🤔 아 누가 샤워 안시켜주나?ㅎ"
]

let cleanMondeeLines = [
    "🤤 후 물맛 좋네",
    "😋 77ㅓ억~",
    "♨️ 사실 더 지지고싶었어",
    "💧 이집 물 맛집이네",
    "🛁 여기 물이 좋다니까",
    "🥸 왜 계속 눌러 너 나 좋아해?",
    "✨ 청소 좀 치는데?"
]