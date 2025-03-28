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
                        RankingView()
                    }
                    .navigationDestination(isPresented: $isShowQuiz){
                        QuizView(viewModel: QuizViewModel(questionCount: 10))
                    }
                    .navigationDestination(isPresented: $isShowSetting){
                        SettingsView(viewModel: QuizViewModel(questionCount: 10))
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

