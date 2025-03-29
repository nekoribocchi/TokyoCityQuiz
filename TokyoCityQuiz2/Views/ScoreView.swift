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
    @ObservedObject var quizViewModel : QuizViewModel
    private let scoreManager = ScoreManager()
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                RoundedTopBar(text: "今回のスコア", isGradient: true)
                
                RoundRectangleView(heightRatio: 0.8){
                    VStack{
                        ZStack{
                            
                            Circle()
                            
                                .foregroundColor(.g_Purple)
                                .opacity(0.4)
                                .padding()
                            VStack{
                                Text("\(quizViewModel.score) 点")
                                    .font(.largeTitle)
                                    .padding()
                                Text("惜しい！もう少し頑張ってみよう！")
                            }
                        }
                        CustomCircleButton(action: {
                            isShowRanking = true
                            quizViewModel.resetQuiz()
                        }, size: 30, icon: Image(systemName: "gearshape.fill"))
                        
                        CustomCircleButton(action: {
                            isShowQuiz = true
                            quizViewModel.resetQuiz()
                        }, size: 30, icon: Image(systemName: "gamecontroller.fill"))
                        
                    }
                }
            }
        }.navigationDestination(isPresented: $isShowRanking){
          RankingView(scoreManager: scoreManager)
        }
        .navigationDestination(isPresented: $isShowQuiz){
            QuizView(viewModel: quizViewModel)
        }
    }
}

#Preview {
    ScoreView(quizViewModel: QuizViewModel(questionCount: 3))
}
