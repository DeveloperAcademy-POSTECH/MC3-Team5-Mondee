//
//  MondeeLevelView.swift
//  Mondee
//
//  Created by Seokmin on 2023/07/25.
//

import SwiftUI

struct MondeeLevelView: View {
    @ObservedObject var viewModel: TodayViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("\(viewModel.currentLevel.name)")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.bottom, 8)
            HStack(alignment: .lastTextBaseline) {
                VStack(alignment: .leading) {
                    Text("\(viewModel.currentLevel.nextLevelMessage)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 4)
                    ProgressView(value: CGFloat(viewModel.successCount), total: CGFloat(viewModel.currentLevel.endNumber))
                        .progressViewStyle(LinearProgressViewStyle(tint: .mondeeBlue))
                }
                HStack(alignment: .lastTextBaseline, spacing: 0) {
                    Text("\(viewModel.successCount)")
                        .font(.title)
                        .fontWeight(.bold)
                    Text(" / \(viewModel.currentLevel.endNumber)")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.all, 20)
        .background(Color.mondeeBoxBackground)
        .cornerRadius(20)
    }
}
