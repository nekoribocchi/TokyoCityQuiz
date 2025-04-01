//
//  VolumeSliderView.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/04/01.
//

import SwiftUI

struct VolumeSliderView: View {
    @Binding var value: Double  // 0.0〜1.0 の範囲
       
       var body: some View {
           GeometryReader { geometry in
               let sliderWidth = geometry.size.width
               let progressWidth = sliderWidth * value
               
               ZStack(alignment: .leading) {
                   // 背景バー（未スライド部分）
                   Capsule()
                       .fill(Color.gray.opacity(0.2))
                       .frame(height: 8)
                   
                   // グラデーション部分（スライドされた部分）
                   Capsule()
                       .fill(
                           LinearGradient(
                            colors: [.r_Purple, .r_Orange],
                               startPoint: .leading,
                               endPoint: .trailing
                           )
                       )
                       .frame(width: progressWidth, height: 8)
                   
                   // ドラッグ可能なハンドル
                   Circle()
                       .fill(Color.white)
                       .frame(width: 30, height: 30)
                       .shadow(radius: 2)
                       .offset(x: max(0, min(progressWidth - 10, sliderWidth - 20)))  // はみ出さないよう制限
                       .gesture(
                           DragGesture()
                               .onChanged { gesture in
                                   let location = gesture.location.x
                                   value = min(max(0, location / sliderWidth), 1)
                               }
                       )
               }
           }
           .frame(height: 30)
           .padding(.horizontal)
       }
}
