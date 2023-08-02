//
//  MondeeBoxView.swift
//  Mondee
//
//  Created by Seokmin on 2023/07/25.
//

import SwiftUI

struct MondeeBoxView: View {
    @ObservedObject var viewModel: TodayViewModel
    @ObservedObject var userData = UserData()
    
    @State private var isMondeeTalking = false
    
    
    var randomMondeeLine: String {
        return viewModel.gameStatus == .finishedSuccess ? cleanMondeeLines.randomElement() ?? "" : dirtyMondeeLines.randomElement() ?? ""
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("먼디")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.bottom, 8)
            
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    Spacer()
                    Image("ImgMondeeShadow-IOS")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                }
                
                if viewModel.gameStatus == .inProgress {
                        Image("ImgMondeeCaution-IOS")
                            .resizable()
                            .scaledToFit()
                            .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                            .animation(.interactiveSpring(response: 0.55 ,dampingFraction:0.68,blendDuration: 0.65))
                } else if viewModel.gameStatus == .finishedSuccess || viewModel.gameStatus == .notStarted {
                    Image(viewModel.todayMondee?.mondeeImg ?? viewModel.currentLevel.mondeeImg)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .padding()
                        .onTapGesture {
                            if !(viewModel.gameStatus == .inProgress) {
                                isMondeeTalking.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation(.easeOut) {
                                        isMondeeTalking = false
                                    }
                                }
                            }
                            print(userData.userdata.description)
                        }
                        .background(){
                            if viewModel.isCheckActive {
                                LottieView(fileName: "MondeeShowAnimation", loopMode: .repeatBackwards(2))
                                    .scaledToFit()
                                    .scaleEffect(0.8)
                            }
                        }
                }
            }
        }
        .overlay(alignment: .top) {
            if isMondeeTalking {
                Text(randomMondeeLine)
                    .padding(.vertical)
                    .padding(.horizontal, 30)
                    .background(Color.mondeeSpeechBubble)
                    .clipShape(Capsule())
                    .shadow(radius: 3)
                    .offset(y: 45)
            }
        }
        .frame(height: 330)
        .padding(.all, 20)
        .background(Color.mondeeBoxBackground)
        .cornerRadius(20)
    }
}

struct MondeeBoxView_Previews: PreviewProvider {
    static var previews: some View {
        MondeeBoxView(viewModel: TodayViewModel())
    }
}
