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
    @State private var animate = false
    @State private var hasAnimated = false
    @State private var isShowLicense = false
    
    @StateObject var quizViewModel =  QuizViewModel()
    private let scoreManager = ScoreManager()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    GradientBackground(startColor: .g_Orange, endColor: .g_Purple)
                    
                    RoundedBottomBar(opacity: 0.7,heightRatio: 0.16){
                        
                        let spacing = geometry.size.width * 0.1
                        
                        HStack(spacing: spacing) {
                            CustomCircleButton(action: {
                                isShowSetting = true
                            }, size: 60, icon: Image(systemName: "gearshape.fill")){
                                Text("設定")
                                    .font(.potta(size: 15))
                                    .foregroundColor(.r_Orange)
                            }
                            
                            CustomCircleButton(action: {
                                quizViewModel.startNewQuiz()
                                isShowQuiz = true
                            }, size: 60, icon: Image(systemName: "gamecontroller.fill")){
                                Text("遊ぶ")
                                    .font(.potta(size: 15))
                                    .foregroundColor(.r_Orange)
                            }
                            
                            CustomCircleButton(action: {
                                isShowRanking = true
                            }, size: 60, icon: Image(systemName: "medal.fill")){
                                Text("スコア")
                                    .font(.potta(size: 15))
                                    .foregroundColor(.r_Orange)
                            }
                        }
                        .navigationDestination(isPresented: $isShowRanking){
                            RankingView(scoreManager: scoreManager)
                        }
                        .navigationDestination(isPresented: $isShowQuiz){
                            QuizView(viewModel: quizViewModel)
                                .environment(\.isInQuiz, true)
                        }
                        .navigationDestination(isPresented: $isShowSetting){
                            SettingView(quizViewModel: quizViewModel)
                        }
                        .navigationDestination(isPresented: $isShowLicense) {
                            InfoView()
                        }
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button(action: {
                                    isShowLicense = true
                                }) {
                                    Image(systemName: "info.circle")
                                        .imageScale(.large)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                    
                    let angle: Double = animate ? 1 : -1
                    VStack{
                        Spacer()
                        VStack{
                            Text("とないくしちょうそん")
                                .font(.potta(size: 20))
                                .foregroundColor(.white)
                                .lineLimit(nil)
                       
                            Text("都内区市町村")
                                .font(.potta(size: 60))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            Text("クイズ")
                                .font(.potta(size: 60))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.bottom,-35)
                        }
                        .rotationEffect(.degrees(angle))
                        .task {
                            if !hasAnimated{
                                withAnimation(
                                    .easeInOut(duration: 0.7)
                                    .repeatForever(autoreverses: true)
                                ) {
                                    animate.toggle()
                                }
                                hasAnimated = true
                            }
                            BGMPlayer.shared.playBackgroundMusic()
                        }
                        Image("icon")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 600)
                        Spacer()
                    }
                    
                    
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
    
}

#Preview {
    MainView()
}

