//
//  RecordTitleArea.swift
//  Mondee
//
//  Created by seunghoria on 2023/07/24.
//

import SwiftUI

struct RecordTitleArea: View {
    @Binding var scrollViewOffset: CGFloat
    
    @ObservedObject var userData: UserData
    
    var body: some View {
        
        /// 최대 연속 횟수 확인 maxConsecutiveSuccessCount 사용
        let (recentConsecutiveSuccessCount, _) = userData.consecutiveSuccessCounts()
        
        
        VStack(alignment: .leading, spacing: 5) {
            Text("연속 성공 0일차🎉")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            Text("성공 버블을 모아보세요")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .opacity(Double(scrollViewOffset / 30 - 0.83))
        .padding(EdgeInsets(top: 0, leading: 40, bottom: 20, trailing: 40))
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.mondeeBoxBackground)
                .edgesIgnoringSafeArea(.top)
                .shadow(color: .black.opacity(0.05), radius: 4, y: 4)
        )
        .onScrollViewOffsetChanged { value in
            scrollViewOffset = value
        }
    }
}

