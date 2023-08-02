//
//  LatestCollectedMondeeView.swift
//  Mondee
//
//  Created by Hyunjun Kim on 2023/07/26.
//

import SwiftUI

struct LatestCollectedMondeeView: View {
    @ObservedObject var collectedModel: CollectedMondeeModel
    
    var body: some View {
        VStack(spacing: 2) {
            if let mostRecentRow = findLatelyDateItems(in: collectedModel.collectedMondees) {
                ZStack {
                    Circle()
                        .frame(width: 168)
                        .foregroundColor(Color(.systemGray6))
                    Image(mostRecentRow.collectedMondeeImg)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110)
                        .padding(.bottom, 15)
                }
                .padding(.bottom, 10)
                Text("최근 획득한 먼디")
                    .font(.callout)
                    .padding(.bottom, 4)
                Text("\(formatDateKorean(date: mostRecentRow.collectedMondeeDate!))에 먼디를 획득했어요")
                    .font(.footnote)
                    .foregroundColor(.mondeeGrey)
            } else {
                Image("ImgCollectedMondee012-IOS")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110)
                    .padding(.bottom, 15)
                Text("최근 획득한 먼디")
                    .font(.callout)
                    .padding(.bottom, 4)
                Text("얼른 먼디를 획득하러 가요!")
                    .font(.footnote)
                    .foregroundColor(.mondeeGrey)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.mondeeBoxBackground)
        )
        .padding(.top, 5)
        .padding(.horizontal, 16)
    }
    
    func findLatelyDateItems(in items: [CollectedMondee]) -> CollectedMondee? {
        guard let firstItemWithDate = items.first(where: { $0.collectedMondeeDate != nil }) else {
            return nil
        }
        
        var latelyDateItem = firstItemWithDate
        
        for item in items {
            if let date = item.collectedMondeeDate {
                if let latelyDate = latelyDateItem.collectedMondeeDate {
                    if date > latelyDate {
                        latelyDateItem = item
                    }
                }
            }
        }
        return latelyDateItem
    }
    
    func formatDateKorean(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "M월 dd일" // 이 형식에 따라 월일이 표시됩니다.
            return dateFormatter.string(from: date)
    }
    
    
}
