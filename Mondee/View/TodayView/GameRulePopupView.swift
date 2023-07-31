//
//  GameRulePopupView.swift
//  Mondee
//
//  Created by Sunjoo IM on 2023/07/28.
//

import SwiftUI

struct GameRulePopupView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct GameRuleView: View {
    
    @State private var selectedImageIndex = 0
    
    let gameRuleDescriptions = [
        "크라운을 돌려\n먼디를 욕조에 넣어서\n씻을 준비를 시켜주세요",
        "청소할 때 발생하는\n움직임으로\n먼디가 깨끗해져요",
        "25초 동안 움직임이 없으면\n버블 하트 하나가 사라지고\n먼디는 더러워져요",
        "10분이 지난 후,\n버블 하트가 하나 이상 남아있으면\n오늘 청소는 성공!",
        "버블 하트가 모두 사라지면\n오늘 청소는 실패\n한번의 기회가 더 주어져요"
    ]
    
    var body: some View {
        ZStack {
            Color.mondeeBackgroundGrey.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    print("Game Rules")
                }
            VStack {
                HStack {
                    Spacer()
                    Button {
                        print("click")
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.black)
                            .offset(x: -8)
                    }
                }
                VStack {
                    Text("플레이 방법")
                        .font(.title)
                        .bold()
                    GameRuleImageSection(selectedImageIndex: $selectedImageIndex)
                    GameRuleDescriptionSection(gameRuleDescription: gameRuleDescriptions[selectedImageIndex])
                        .padding(.bottom)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 600)
            .background()
            .cornerRadius(25)
        }
        .padding(.horizontal)
    }
}

struct GameRuleImageSection: View {
    
    @Binding var selectedImageIndex: Int
    @State private var gameRuleImages = [
        "ImgGameRule1-iOS",
        "ImgGameRule2-iOS",
        "ImgGameRule3-iOS",
        "ImgGameRule4-iOS",
        "ImgGameRule5-iOS"
    ]
    
    var body: some View {
        VStack {
            TabView(selection: $selectedImageIndex) {
                ForEach(gameRuleImages.indices, id: \.self) { gameRuleImage in
                    GameRuleWatchImage(gameRuleImage: gameRuleImages[gameRuleImage])
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .onAppear {
                setupAppearance()
            }
            .frame(height: 400)
        }
    }
    
    // 먼디칼라로 바꿔야되는디 어케하누
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .systemTeal
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.5)
    }
}

struct GameRuleWatchImage: View {
    
    var gameRuleImage: String
    
    var body: some View {
        Image(gameRuleImage)
            .resizable()
            .frame(maxWidth: 330)
            .padding()
    }
}

struct GameRuleDescriptionSection: View {
    
    var gameRuleDescription: String
    
    var body: some View {
        Text(gameRuleDescription)
            .multilineTextAlignment(.center)
    }
}

struct GameRuleView_Previews: PreviewProvider {
    static var previews: some View {
        GameRuleView()
    }
}
