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
    @State private var isShowHome = false
    @StateObject var quizViewModel =  QuizViewModel()
    @State private var animate = false
    private let scoreManager = ScoreManager()
    @State private var isInQuiz = false
    
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
                        SettingView(quizViewModel: quizViewModel)
                    }
                    let angle: Double = animate ? 3 : -3
                    VStack{
                        Text("とないくしちょうそん")
                            .font(.potta(size: 20))
                            .foregroundColor(.white)
                            .lineLimit(nil)
                            .padding(.top, 100)
                        
                        Text("都内区市町村")
                            .font(.potta(size: 60))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Text("クイズ")
                            .font(.potta(size: 60))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Spacer()
                    }
                    .rotationEffect(.degrees(angle))
                    .onAppear {
                        withAnimation(
                            .easeInOut(duration: 0.9)
                            .repeatForever(autoreverses: true)
                        ) {
                            animate.toggle()
                        }
                    }
                    Image("icon")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 700)
                        .padding(.top,60)
                        .edgesIgnoringSafeArea(.bottom)
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    
    MainView()
}

