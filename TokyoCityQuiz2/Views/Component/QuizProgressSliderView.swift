//
//  QuizProgressSliderView.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/04/02.
//

import SwiftUI

struct QuizProgressSliderView: View {
    var progress: Double

    var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width
            let filledWidth = totalWidth * progress

            ZStack(alignment: .leading) {
                // 背景バー（未回答部分）
                Capsule()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 8)

                // 進んだ部分（カラフルなバー）
                Capsule()
                    .fill(
                        LinearGradient(colors: [.r_Purple, .r_Orange],
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .frame(width: filledWidth, height: 8)
            }
        }
        .padding(.horizontal)
        .frame(height: 20)
       
    }
}


#Preview {
    QuizProgressSliderView(progress: 2)
}
