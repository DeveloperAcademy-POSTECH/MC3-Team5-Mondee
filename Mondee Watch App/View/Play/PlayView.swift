//
//  PlayView.swift
//  Mondee Watch App
//
//  Created by Seokmin on 2023/07/15.
//

import SwiftUI

enum PlayViewSelection {
    case option
    case game
}

struct PlayView: View {
    @StateObject private var gameState = GameStateManager()
    
    @State var selection: PlayViewSelection = .game
    @State private var warningRemainSeconds = Double(Constants.dirtThreshold - Constants.warningThreshold)
    
    @Binding var gameStatus: GameStatus
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                GameOptionView(selection: $selection, gameStatus: $gameStatus)
                    .environmentObject(gameState)
                    .tag(PlayViewSelection.option)
                
                GeometryReader { geo in
                    let deviceWidth = geo.size.width
                    
                    ZStack() {
                        MondeeImageView(gameState: gameState)
                        
                        if gameState.isCharacterBubbling {
                            VStack {
                                Spacer()
                                Image("ImgBathTubBubble-WatchOS")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: deviceWidth)
                            }
                        }
                        
                        VStack {
                            Spacer()
                            Image("ImgBathTubTower-WatchOS")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: deviceWidth)
                                .edgesIgnoringSafeArea(.all)
                        }
                        VStack {
                            Spacer()
                            Text("\(formatTime(gameState.remainingSeconds))")
                                .font(.largeTitle).foregroundColor(.black)
                                .timerFontModifier()
                                .frame(maxWidth: .infinity)
                                .monospacedDigit()
                        }.padding(.bottom, CGFloat(12))
                    }
                    .ignoresSafeArea()
                    .onAppear {
                        gameState.playGame()
                    }
                    VStack {
                        Spacer()
                        Text("\(formatTime(gameState.remainingSeconds))")
                            .font(.largeTitle).foregroundColor(.black)
                    }.padding(.bottom, CGFloat(12))
                }
                .ignoresSafeArea()
                .onAppear {
                    gameState.playGame()
                }
                
                if gameState.isPreWarning {
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundColor(Color.yellow.opacity(0.2))
                        .blur(radius: 8)
                }
            }
            .navigationTitle {
                HeartCountView(gameState: gameState)
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        .overlay {
            if gameState.isWarning {
                WarningView()
            }
        }
    }
    
    private func startBlinking() {
        withAnimation {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                warningRemainSeconds -= 0.5
                if warningRemainSeconds == 0 {
                    warningRemainSeconds = Double(Constants.dirtThreshold - Constants.warningThreshold)
                    return
                }
                startBlinking()
            }
        }
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let formattedSeconds = String(format: "%02d", seconds % 60)
        return "\(minutes):\(formattedSeconds)"
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView(gameStatus: .constant(.play))
    }
}
