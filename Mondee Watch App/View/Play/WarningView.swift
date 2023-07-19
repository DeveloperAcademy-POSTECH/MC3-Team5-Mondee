//
//  WarningView.swift
//  Mondee Watch App
//
//  Created by hyunjun on 2023/07/19.
//

import SwiftUI

struct WarningView: View {
    
    @State private var warningRemainSeconds = Double(Constants.dirtThreshold - Constants.warningThreshold)

    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(Color.black)
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(Int(warningRemainSeconds * 2) % 2 == 0 ? Color.red.opacity(0.3) : .clear)
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Group {
                        Text("🚨")
                        Text("어서어서")
                        Text("움직이라구")
                    }
                    .font(.title3)
                    Text("\(Int(warningRemainSeconds + 0.5))")
                        .font(.system(size: 100))
                        .modifier(BubbleFontModifier())
                    Spacer()
                }
                Spacer()
            }
        }
        .onAppear {
            startBlinking()
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
}

struct WarningView_Previews: PreviewProvider {
    static var previews: some View {
        WarningView()
    }
}
