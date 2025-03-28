//
//  RankingView.swift
//  TokyoCityQuiz2
//
//  Created by 羽田野真央 on 2025/02/04.
//

import SwiftUI
import GlassmorphismUI

struct RankingView: View {
    var body: some View {
        ZStack{
            RoundedTopBar(text: "ランキング", isGradient: true)
            
            RoundRectangleView(heightRatio: 0.8){
                
                List {
                    ForEach(0..<10) { i in
                        Text("項目 \(i)")
                            .foregroundColor(.black)
                    }
                    .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
                .background(Color.clear)
            }
        }
        }
    }

#Preview {
    RankingView()
}
