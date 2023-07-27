//
//  LevelPopupView.swift
//  Mondee
//
//  Created by woozu on 2023/07/25.
//

import SwiftUI

struct LevelPopupView: View {
    
    @Binding var isLevelInfoPopup: Bool
    
    let LevelMondee : [LevelInfo] = [
        .init( mondeeImg: "ImgMondeeLevel1-IOS", mondeeTitle:"청응애" , mondeeContents: "응애 나 아기먼디"),
        .init( mondeeImg: "ImgMondeeLevel2-IOS", mondeeTitle:"청린이" , mondeeContents: "청소 4번 성공 시"),
        .init( mondeeImg: "ImgMondeeLevel3-IOS", mondeeTitle:"청년" , mondeeContents: "청소 8번 성공 시"),
        .init( mondeeImg: "ImgMondeeLevel4-IOS", mondeeTitle:"청른이" , mondeeContents: "청소 12번 성공 시"),
        .init( mondeeImg: "ImgMondeeLevel5-IOS", mondeeTitle:"청고수" , mondeeContents: "청소 20번 성공 시")
    ]
    
    var body: some View {
        ZStack {
            Color.mondeeDarkGrey.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    isLevelInfoPopup = false
                }
            
            VStack(spacing: 12.0) {
                HStack(alignment: .top) {
                    Spacer()
                    Button {
                        isLevelInfoPopup = false
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.white)
                            .offset(x: -8)
                    }
                    .buttonStyle(MondeeButtonClickStyle())
                }
                
                VStack(spacing: 0.0) {
                    
                    Text("청소 장인")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("청소 성공 횟수에 따라")
                    Text("레벨이 올라가요!")
                        .padding(.bottom,20)
                    Rectangle()
                        .frame(height: 1.0)
                        .opacity(0.2)
                    
                    ForEach(LevelMondee) { level in
                        
                        HStack{
                            Image(level.mondeeImg)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60)
                                .padding()
                            VStack(alignment: .leading){
                                Text(level.mondeeTitle)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                
                                Text(level.mondeeContents)
                            }
                        }
                        .padding(.trailing,100)
                    }
                }
                .frame(height: 600.0)
                .background()
                .cornerRadius(25)
                .frame(maxWidth: .infinity)
            }.padding(.horizontal)
        }
    }
}
