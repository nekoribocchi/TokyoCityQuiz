//
//  ScoreView.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/03/29.
//

import SwiftUI
import GlassmorphismUI

struct ScoreView: View {
    @State private var isShowQuiz = false
    @State private var isShowSetting = false
    @State private var isShowRanking = false
    @State private var isShowHome = false
    @State private var isFromScoreView = false
    @ObservedObject var quizViewModel : QuizViewModel
    private let scoreManager = ScoreManager()
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                RoundedTopBar(text: "今回のスコア", isGradient: true)
                
                RoundRectangleView(heightRatio: 0.8){
                    VStack{
                        
                        CircleGradientView(content: {
                            VStack{
                                Text("30点")
                                    .font(.potta(size: 60))
                                
                                Text("その調子！")
                                    .font(.custom("PottaOne-Regular", size: 20))
                            }
                        })
                                              
                        ButtonBase.simple(
                            title: "リプレイ",
                            font: "PottaOne-Regular",
                            isFurigana: true,
                            furigana: "りぷれい",
                            action: {
                                isShowQuiz = true
                                quizViewModel.resetQuiz()
                            }
                        )
                        
                        ButtonBase.simple(
                            title: "スコア一覧へ",
                            font: "PottaOne-Regular",
                            isFurigana: true,
                            furigana: "すこあいちらんへ",
                            action: {
                                isShowRanking = true
                                isFromScoreView = true
                                quizViewModel.resetQuiz()
                            }
                        )
                        ButtonBase.simple(
                            title: "ホーム画面へ",
                            font: "PottaOne-Regular",
                            isFurigana: true,
                            furigana: "ほーむがめんへ",
                            action: {
                                isShowHome = true
                                quizViewModel.resetQuiz()
                            }
                        )
                        
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        .navigationDestination(isPresented: $isShowRanking){
            RankingView(scoreManager: scoreManager, fromScoreView: $isFromScoreView)
        }
        .navigationDestination(isPresented: $isShowQuiz){
            QuizView(viewModel: quizViewModel)
        }
        .navigationDestination(isPresented: $isShowHome){
            MainView()
        }
    }
}

#Preview {
    ScoreView(quizViewModel: QuizViewModel(questionCount: 3))
}
