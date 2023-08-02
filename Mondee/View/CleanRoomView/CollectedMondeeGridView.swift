//
//  CollectedMondeeGridView.swift
//  Mondee
//
//  Created by Hyunjun Kim on 2023/07/26.
//

import SwiftUI

struct CollectedMondeeGridView: View {
    @Binding var isDetailCardPopUp: Bool
    @Binding var collected: CollectedMondee
    
    @ObservedObject var collectedModel: CollectedMondeeModel
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(collectedModel.collectedMondees) { collectedMondee in
                Button {
                    collected = collectedMondee
                    withAnimation() {
                        isDetailCardPopUp = true
                    }
                } label: {
                    VStack{
                        ZStack {
                            Circle()
                                .frame(width: 86)
                                .foregroundColor(Color(.systemGray6))
                            // MARK: collectedMondee.isCollected == true 지만 발표 gif를 위한 테스트 코드
                            if collectedMondee.isCollected == false {
                                Image(collectedMondee.collectedMondeeImg)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 55, height: 55)
                            } else {
                                Image(systemName: "lock.fill")
                                    .font(.system(.largeTitle, weight: .bold))
                                    .foregroundColor(.mondeeGrey)
                            }
                        }
                        .padding(.bottom, 10)
                        
                        Text("\(collectedMondee.collectedMondeeName)")
                            .font(.system(size: 12, weight: .regular))
                    }
                }
                .buttonStyle(MondeeButtonClickStyle())
//                MARK: 발표 시 캐릭터 클릭 가능 코드
//                .disabled(!collectedMondee.isCollected)
            }
        }
        .padding(.vertical, 8)
        .padding(17)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.mondeeBoxBackground)
        )
        .padding(.top, 5)
        .padding(.bottom, 24)
        .padding(.horizontal, 16)
    }
}

