//
//  RankingView.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/02/04.
//

import SwiftUI
import GlassmorphismUI

struct RankingView: View {
    let scoreManager: ScoreManager
    
    enum Medal {
        case gold, silver, copper
        
        var color: Color {
            switch self {
            case .gold: return .yellow
            case .silver: return .gray
            case .copper: return .brown
            }
        }
    }
    
    var body: some View {
        ZStack {
            RoundedTopBar(isGradient: true){
                Text("スコア一覧")
                    .font(.potta(size: 30))
                    .foregroundColor(.white)
            }
            
            RoundRectangleView(heightRatio: 0.8) {
                List {
                    ForEach(Array(scoreManager.getTopScores().prefix(10).enumerated()), id: \.offset) { index, score in
                        HStack {
                            if index < 3 {
                                let medal: RankMark.Medal = {
                                    switch index {
                                    case 0: return .gold
                                    case 1: return .silver
                                    default: return .copper
                                    }
                                }()
                                RankMark(medal: medal)
                                Spacer()
                                Text("\(score.score) 点")
                                    .font(.potta(size: 20))
                                
                                Spacer()
                                Text ("\(score.date.formatted(.dateTime.locale(Locale(identifier: "ja_JP")).year().month().day().hour().minute()))")
                                    .font(.potta(size: 10))

                            } else {
                                Circle()
                                    .fill(Color.clear)
                                    .frame(width: 28, height: 28)
                                Spacer()
                                Text("\(score.score) 点")
                                    .font(.potta(size: 15))
                                
                                Spacer()
                                Text ("\(score.date.formatted(.dateTime.locale(Locale(identifier: "ja_JP")).year().month().day().hour().minute()))")
                                    .font(.potta(size: 8))
      
                            }
                            

                        }
                        .listRowBackground(Color.clear)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.clear)
            }
            
            BackButton()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RankingView(scoreManager: ScoreManager())
}
