//
//  FailView.swift
//  Mondee Watch App
//
//  Created by woozu on 2023/07/14.
//

import SwiftUI

struct RetryFailView: View {
    
    @Binding var isFinalFail: Bool
    @Binding var gameStatus: GameStatus
    @Binding var isGameRestart: Bool
    
    
    var body: some View {
        VStack{
            Image("ImgFail-WatchOS")
                .resizable()
                .scaledToFit()
                .frame(width: 75,height: 75)
                
            Text("더 씻겨주세요")
                .font(.body)
                .fontWeight(.medium)
            Button("다시 도전"){
                gameStatus = .guide
                isGameRestart = true
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(hue: 0.593, saturation: 0.893, brightness: 0.876, opacity: 0.827))
            
            Button("오늘은 그만"){
                isFinalFail = true
            }
            .buttonStyle(.borderedProminent)
            
        }
    }
}


struct FailView_Previews: PreviewProvider {
    static var previews: some View {
        RetryFailView(isFinalFail: .constant(false), gameStatus: .constant(.fail), isGameRestart: .constant(false))
    }
}
