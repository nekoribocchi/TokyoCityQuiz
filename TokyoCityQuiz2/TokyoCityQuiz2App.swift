//
//  TokyoCityQuiz2App.swift
//  TokyoCityQuiz2
//
//  Created by 羽田野真央 on 2025/02/04.
//

import SwiftUI

@main
struct TokyoCityQuiz2App: App {
    @State private var hasCompletedOnboarding: Bool = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    @StateObject private var settingViewModel = SettingViewModel()
    @StateObject private var quizViewModel: QuizViewModel
    
    init() {
        // SettingViewModelを先に生成してquestionCountを取得
        let settingVM = SettingViewModel()
        _settingViewModel = StateObject(wrappedValue: settingVM)
        _quizViewModel = StateObject(wrappedValue: QuizViewModel(questionCount: settingVM.questionCount))
    }

    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                MainView(quizViewModel: quizViewModel)
                    .environmentObject(settingViewModel)
            } else {
                OnboardingView(onboardingCompleted: {
                    UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                    hasCompletedOnboarding.toggle()
                })
            }
        }
    }
}

