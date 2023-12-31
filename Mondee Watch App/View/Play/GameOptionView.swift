//
//  GameOptionView.swift
//  Mondee Watch App
//
//  Created by hyunjun on 2023/07/17.
//

import SwiftUI

struct GameOptionView: View {
    @EnvironmentObject var gameState: GameStateManager
    
    @State var isPauseButton = true
    @State var gameTerminationAlert = false
    @State var gameEarlySuccessAlert = false
    
    @Binding var selection: PlayViewSelection
    @Binding var gameStatus: GameStatus
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        WatchButton(SFSymbol: "checkmark", label: "청소 완료") {
                            gameEarlySuccessAlert = true
                        }
                        .disabled(!gameState.isEarlyTerminationPossible)
                        .tint(.blue)
                        WatchButton(SFSymbol: isPauseButton ? "pause" : "arrow.clockwise", label: isPauseButton ? "일시 정지" : "재개") {
                            isPauseButton.toggle()
                            if isPauseButton {
                                gameState.resumeGame()
                                gameState.watchDataModel.isPaused = false
                                sendData()
                            }
                            else {
                                gameState.pauseGame()
                                gameState.watchDataModel.isPaused = true
                                sendData()
                            }
                        }
                        .tint(.yellow)
                    }
                    HStack {
                        WatchButton(SFSymbol: "xmark", label: "청소 포기") {
                            gameTerminationAlert = true
                        }
                        .tint(.red)
                        
                        WatchButton(SFSymbol: "", label: "") {
                            //action here
                        }
                        .tint(.clear)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .center)
                .edgesIgnoringSafeArea(.bottom)
                .alert("게임을 포기하시겠어요?", isPresented: $gameTerminationAlert) {
                    Button(role: .destructive) {
                        gameState.giveUpGame()
                        gameStatus = .fail
                        gameState.isGameFinished = true
                        
                        
                    } label: {
                        Text("청소 포기")
                    }
                    Button("취소", role: .cancel) {}
                }
                .alert("정말 청소를 완료하셨어요?", isPresented: $gameEarlySuccessAlert) {
                    Button {
                        DispatchQueue.main.async {
                            gameState.successGameEarly()
                            gameState.isGameFinished = true
                        }
                    } label: {
                        Text("완료했어요")
                    }
                    Button("취소", role: .cancel) {}
                }
            }
            .navigationTitle {
                HStack {
                    Text(isPauseButton ? "게임 중" : "일시정지 됨")
                        .foregroundColor(isPauseButton ? .blue : .yellow)
                    Spacer()
                }
                .foregroundColor(.green)
            }
        }
    }
    private func sendData() {
        gameState.watchDataModel.session.transferUserInfo(["GameSuccess":gameState.watchDataModel.isSuccess,"GameFail":gameState.watchDataModel.isFail, "GamePlayTime":gameState.watchDataModel.gamePlayTime, "GameDate":gameState.watchDataModel.gameDate, "RemainHeart":gameState.watchDataModel.remainHeart, "GameRetry":gameState.watchDataModel.isRetry,"GameStart":gameState.watchDataModel.isStart,"GamePaused":gameState.watchDataModel.isPaused])
        print("데이터 전송")
    }
}

struct WatchButton: View {
    
    var SFSymbol: String
    var label: String
    var action: () -> Void
    
    var body: some View {
        VStack {
            Button(action: action) {
                Image(systemName: SFSymbol)
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(height: 35)
            }
            Text(label)
                .font(.caption2)
        }
    }
}

