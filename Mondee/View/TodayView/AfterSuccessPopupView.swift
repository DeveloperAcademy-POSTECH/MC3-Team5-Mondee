//
//  AfterSuccessPopupView.swift
//  Mondee
//
//  Created by woozu on 2023/07/26.
//

import SwiftUI

struct AfterSuccessPopupView: View {
    var body: some View {
        ZStack{
            Color("mondeeBackgroundGrey")
                .ignoresSafeArea()
            VStack{
                Text("청소 성공!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("mondeeBlue"))
                    .padding(.bottom,1)
                    
                
                Text("메인화면에서")
                    .font(.title2)

                HStack{
                    Text("바뀐 먼디를 확인")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("해보세요")
                        .font(.title2)
                }
                .padding(.bottom,50)
                Image("ImgAfterSucessPopup-iOS")
                    .resizable()
                    .frame(width: 273,height: 251)
                 
                
                MondeeBlueButton(label: "확인하러가기") {
                }
                .padding(.horizontal,30)
                .padding(.top,30)
                
            }
            .frame(height: 600.0)
            .frame(maxWidth: .infinity)
            .background()
            .cornerRadius(25)
            .padding(.horizontal)
        }
    }
}

struct AfterSuccessPopupView_Previews: PreviewProvider {
    static var previews: some View {
        AfterSuccessPopupView()
    }
}
