//
//  CollectedMondeeDetailCardView.swift
//  Mondee
//
//  Created by Hyunjun Kim on 2023/07/26.
//

import SwiftUI

struct CollectedMondeeDetailCardView: View {
    
    @Binding var isDetailCardPopUp: Bool
    @Binding var collected: CollectedMondee
    
    var body: some View {
        ZStack {
            Color.mondeeDarkGrey.opacity(0.5).ignoresSafeArea()
                .onTapGesture {
                    isDetailCardPopUp = false
                }
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(collected.collectedMondeeName)
                            .font(.system(size: 24, weight: .bold))
                            .fontWeight(.semibold)
                        if let date = collected.collectedMondeeDate {
                        Text("잡은날짜 \(formatDateDot(date: date))")
                            .font(.system (size: 15))
                        }
                    }
                    .padding(30)
                    Spacer()
                    Button {
                        isDetailCardPopUp = false
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .opacity(0.6)
                            .offset(x: -10, y: -30)
                    }
                    .buttonStyle(MondeeButtonClickStyle())
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                Rectangle()
                    .frame(height: 1)
                    .padding(.top, -20)
                    .foregroundColor(.white)
                
                Image(collected.collectedMondeeImg)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.bottom, 15)
                Spacer()
                Text(collected.collectedMondeeDescription)
                    .font(.system(size: 15))
                    .lineSpacing(5)
                    .foregroundColor(.white)
                Spacer()
                Text("MonDee")
                    .font(.system(.body, design: .rounded, weight: .bold))
                    .foregroundColor(.mondeeMint)
                Spacer()
                
            }
            .frame(height: 500)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .foregroundColor(.mondeeDarkBlue).opacity(0.5)
                    .backgroundBlurEffect().cornerRadius(20)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 8)
            )
            .padding(.horizontal, 24)
            .padding(.bottom)
        }
    }
    
    func formatDateDot(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yy.MM.d" // 이 형식에 따라 월일이 표시됩니다.
            return dateFormatter.string(from: date)
    }
}
