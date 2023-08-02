//
//  RecordView.swift
//  Mondee
//
//  Created by hyunjun on 2023/07/20.
//

import SwiftUI

struct RecordView: View {
    @State var currentDate = Date()
    @State private var scrollViewOffset: CGFloat = 0
    
    @State var currentMonth : Int = 0 // 화살표 클릭으로 인한 월 세는 변수
    
    @ObservedObject var userData = UserData()
    
    
    var body: some View {
        
        ZStack(alignment: .top){
            Color.mondeeBoxBackground.ignoresSafeArea()
                .frame(height: scrollViewOffset > 0 ? scrollViewOffset : 0)
            
            ScrollView{
                VStack(spacing: 15){
                    RecordTitleArea(scrollViewOffset: $scrollViewOffset, userData: userData)
                        .overlay{
                            Button {
                                let newGameSuccess = true
                                let newGameFail = false
                                let newGamePlayTime = 600
                                let newGamePlayDate = userData.generateRandomDateInJuly()
                                let newRemainingHeartCount = 2
                                let newGameRetry = false
                                let newGameStart = true
                                let newGamePause = false
                                
                                userData.save(
                                    newGameSuccess,
                                    newGameFail,
                                    newGamePlayTime,
                                    newGamePlayDate,
                                    newRemainingHeartCount,
                                    newGameRetry,
                                    newGameStart,
                                    newGamePause
                                )
                            } label: {
                                Rectangle()
                                    .fill(Color.clear)
                            }
                            
                        }
                    VStack(spacing: 15){
                        RecordCalendarArea(currentDate: $currentDate, currentMonth: $currentMonth)
                        MonthStatistics(userData: userData, currentMonth: $currentMonth)
                        TotalStatistics(userData: userData)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                }
                
            }
            .safeAreaInset(edge: .bottom) { Color.clear.frame(height: 0) }
            .safeAreaInset(edge: .top) { Color.clear.frame(height: 30) }
            .overlay(alignment: .top) {
                InlineNavigationTitle(scrollViewOffset: scrollViewOffset,title: "기록실")
            }
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
