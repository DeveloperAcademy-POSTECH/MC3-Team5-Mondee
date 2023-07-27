//
//  ContentView.swift
//  Mondee
//
//  Created by hyunjun on 2023/07/11.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    @StateObject var data = PhoneDataModel.shared
    
    var body: some View {
        Group{
            if isOnboarding {
                OnboardingView()
            } else {
                CustomTabView()
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(.spring(response: 0.5,dampingFraction: 0.75), value: isOnboarding)
        // TODO: TEST CODE 삭제 바람
//        ScrollView{
//            VStack{
//                Text("async : \(data.description)")
//                Divider()
//                Text("userDefaults : \(data.userData.userdata.description)")
//            }
//        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
