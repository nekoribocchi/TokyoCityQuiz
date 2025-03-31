//
//  RankingView.swift
//  TokyoCityQuiz2
//
//  Created by 羽田野真央 on 2025/02/04.
//

import SwiftUI
import GlassmorphismUI

struct RankingView: View {
    let scoreManager:ScoreManager
    @Binding var fromScoreView: Bool
    
    var body: some View {
        ZStack{
            RoundedTopBar(text: "スコア一覧", isGradient: true)
            
            RoundRectangleView(heightRatio: 0.8){
                
                List {
                    ForEach(Array(scoreManager.getTopScores().prefix(10).enumerated()), id: \.offset) { index, score in
                        Text("\(score.score) 点\(score.date.formatted(date: .abbreviated, time: .shortened))")
                    }
                    
                    .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
                .background(Color.clear)
            }
            BackButton()
        }
        .navigationBarBackButtonHidden(true)
        }
    }
//
//#Preview {
//    RankingView(scoreManager: ScoreManager(), fromScoreView: true)
//}
