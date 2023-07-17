//
//  StartGame.swift
//  Mondee Watch App
//
//  Created by 하명관 on 2023/07/13.
//

import SwiftUI

enum GameStatus {
    case beforeGame, playingGame, afterGame
}

struct GameView: View {
    @State private var gameStatus: GameStatus = .beforeGame
    @State private var mondeeScroll: CGFloat = 0.0
    @State private var isGuideActive: Bool = false
    @State private var isGameStartActive: Bool = false
    
    
    private let bottomScrollLimit: CGFloat = -270
    private let gameStartScroll: CGFloat = -280
    
    var body: some View {
        
        startGameOnCharacterReachedBath()
        
        // TODO: 추후 print 코드 제거 요망
        let _ = print("mondeeScroll : \(mondeeScroll)")
        
        switch gameStatus {
        case .beforeGame:
            return AnyView(BeforeGameView(mondeeScroll: $mondeeScroll, isGuideActive: $isGuideActive, bottomScrollLimit: bottomScrollLimit))
        case .playingGame:
            return AnyView(Text("Playing"))
        case .afterGame:
            return AnyView(GameGuideView(isGuideActive: $isGuideActive).transition(.move(edge: .bottom)))
        }
    }
    
    // MARK: Fuctions
    
    fileprivate func startGameOnCharacterReachedBath() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            if mondeeScroll <= bottomScrollLimit {
                mondeeScroll = gameStartScroll
                isGuideActive = true
                WKInterfaceDevice.current().play(.start)
                whenCancel()
            }
        }
    }
    
    fileprivate func whenCancel() {
        if isGuideActive == false {
            mondeeScroll = 0
        }
    }
}


struct GameGuideView: View {
    @State private var showGameCountView = false
    @Binding var isGuideActive: Bool
    
    var body: some View{
        VStack{
            if showGameCountView {
                BeforeGameCountView(isGuideActive: $isGuideActive)
            } else {
                HStack{
                    Image("ImageWatchBubbles")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 27)
                    Text("청소시간")
                        .font(.system(size: 20, weight: .semibold))
                    Image("ImageWatchBubble")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24)
                }
                .padding(.bottom, 10)
                Text("몸을 움직여\n먼지를 씻겨주자")
                    .font(.system(size: 15, weight: .regular))
                    .multilineTextAlignment(.center)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                showGameCountView = true
            }
        }
        
    }
}



struct StartGame_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
