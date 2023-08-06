//
//  ShareView.swift
//  Mondee
//
//  Created by Hyunjun Kim on 2023/07/22.
//

import SwiftUI

struct ShareView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var renderedImage = Image(systemName: "photo")
    
    @State private var selection = 0
    @State private var toastAnimation = false
    
    @Namespace private var namespace
    
    /// 입혀야 할 데이터
    @State var cleaningTime = 240
    
    @ObservedObject var viewModel: TodayViewModel

    var body: some View {
        ZStack {
            Color.mondeeBackgroundGrey.ignoresSafeArea()
            VStack {
                Spacer()
                VStack(alignment: .center) {
                    Text("오늘 획득한 먼디를 자랑해보세요!")
                        .font(.title3)
                        .fontWeight(.medium)
                    SharingCardView(selection: selection, cleaningTime: cleaningTime, viewModel: viewModel)
                        .onAppear {
                            renderedImage = renderImage(for: selection)
                        }
                        .cornerRadius(20)
                        .shadow(radius: 4, y: 4)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
                
                HStack(spacing: 20) {
                    Button {
                        withAnimation() {
                            selection = 0
                        }
                        renderedImage = renderImage(for: 0)
                        
                    } label: {
                        ZStack {
                            Circle()
                                .foregroundColor(.mondeeBlue)
                                .frame(width: 44)
                                .opacity(0.2)
                            if selection == 0 {
                                Circle()
                                    .foregroundColor(.mondeeBlue)
                                    .frame(width: 44)
                                    .opacity(0.7)
                                    .matchedGeometryEffect(id: "shareTab", in: namespace)
                            }
                            Image("sharingCardBubbleButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 23)
                        }
                    }
                    Button {
                        withAnimation() {
                            selection = 1
                        }
                        renderedImage = renderImage(for: 1)
                    } label: {
                        ZStack {
                            Circle()
                                .foregroundColor(.mondeeBlue)
                                .frame(width: 44)
                                .opacity(0.2)
                            if selection == 1 {
                                Circle()
                                    .foregroundColor(.mondeeBlue)
                                    .frame(width: 44)
                                    .opacity(0.7)
                                    .matchedGeometryEffect(id: "shareTab", in: namespace)
                            }
                            Image("sharingCardCloudButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 26)
                        }
                    }
                }
                Spacer()
                Spacer()
                HStack(spacing: 12) {
                    MondeeGreyButton(label: "사진 저장하기") {
                        let ren = ImageRenderer(content: SharingCardView(selection: selection, cleaningTime: cleaningTime, viewModel: viewModel))
                        ren.scale = 3
                        if let image = ren.uiImage {
                            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        }
                        withAnimation(.easeInOut(duration: 0.4)) {
                            toastAnimation = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                            withAnimation(.easeInOut(duration: 1.8)) {
                                toastAnimation = false
                            }
                        }
                    }
                    
                    ShareLink(item: renderedImage, preview: SharePreview(Text("먼디를 자랑해 보세요!"), image: renderedImage)) {
                        Text("공유하기")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Capsule().foregroundColor(.mondeeBlue))
                    }
                    .buttonStyle(MondeeButtonClickStyle())
                }
                .padding(.vertical, 5)
                .padding(.horizontal)
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading, content: {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.mondeeGrey)
                        .fontWeight(.semibold)
                        .padding(.leading, -30)
                }

            })
        }
        .overlay {
            if toastAnimation {
                toastBox(text: "사진이 저장되었습니다")
                    .frame(maxHeight: .infinity, alignment: .top)
                    .transition(.move(edge: .top))
                    .offset(y: -30)
            }
        }
    }
    
    @ViewBuilder
    private func toastBox(text: String) -> some View {
        Text(text)
            .font(.system(size: 14))
            .padding()
            .background(
                Capsule()
                    .foregroundStyle(.thinMaterial)
                    .shadow(radius: 2)
            )
    }
    
    @MainActor
    private func renderImage(for selection: Int) -> Image {
        let renderer = ImageRenderer(content: SharingCardView(selection: selection, cleaningTime: cleaningTime, viewModel: viewModel))
        renderer.scale = 3
        
        if let image = renderer.cgImage {
            return Image(decorative: image, scale: 1.0)
        } else {
            // 기본 이미지를 반환하거나 필요에 따라 오류 상황을 처리합니다.
            return Image(systemName: "photo")
        }
    }
}
