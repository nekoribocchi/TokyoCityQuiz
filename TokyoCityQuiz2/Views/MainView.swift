//
//  ContentView.swift
//  TokyoCityQuiz2
//
//  Created by 羽田野真央 on 2025/02/04.
//

import SwiftUI
import GlassmorphismUI

struct MainView: View {
    @State private var isShowQuiz = false
    @State private var isShowSetting = false
    @State private var isShowRanking = false
    @StateObject var quizViewModel =  QuizViewModel(questionCount: 3)
    private let scoreManager = ScoreManager()

    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    GradientBackground(startColor: .g_Orange, endColor: .g_Purple)
                    
                    RoundedBottomBar()
               
                    VStack {
                        Spacer()
                    
                        let buttonSize = geometry.size.width * 0.15
                        let spacing = geometry.size.width * 0.1
                        
                        HStack(spacing: spacing) {
                            CustomCircleButton(action: {
                                isShowSetting = true
                            }, size: buttonSize, icon: Image(systemName: "gearshape.fill"))

                            CustomCircleButton(action: {
                                isShowQuiz = true
                            }, size: buttonSize, icon: Image(systemName: "gamecontroller.fill"))

                            CustomCircleButton(action: {
                                isShowRanking = true
                            }, size: buttonSize, icon: Image(systemName: "medal.fill"))
                        }
                        .padding(.bottom, geometry.safeAreaInsets.bottom)

                    }
                    .navigationDestination(isPresented: $isShowRanking){
                        RankingView(scoreManager: scoreManager)
                    }
                    .navigationDestination(isPresented: $isShowQuiz){
                        QuizView(viewModel: quizViewModel)
                    }
                    .navigationDestination(isPresented: $isShowSetting){
                        SettingView(viewModel: QuizViewModel(questionCount: 10))
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}


#Preview {
   
    MainView()
}

