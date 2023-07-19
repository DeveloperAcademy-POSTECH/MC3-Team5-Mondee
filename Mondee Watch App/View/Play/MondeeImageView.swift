    //
//  MondeeImageView.swift
//  Mondee Watch App
//
//  Created by Seokmin on 2023/07/19.
//

import SwiftUI

struct MondeeImageView: View {
    @ObservedObject var gameState: GameStateManager
    
    var body: some View {
        let image: Image
        
        switch (gameState.isCharacterClean, gameState.isCharacterBubbling) {
        case (true, true):
            image = Image("ImgMondeeHappySmile-WatchOS")
        case (true, false):
            image = gameState.isPreWarning ? Image("ImgMondeeSad-WatchOS") : Image("ImgMondeeWhite-WatchOS")
        case (false, _):
            image = Image("ImgMondeeBlack-WatchOS")
        }
        
        return image
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
            .padding(CGFloat(25))
            .padding(.top,50)
    }
}
