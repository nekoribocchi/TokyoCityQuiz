//
//  TokyoCityQuiz2App.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/02/04.
//

import SwiftUI

@main
struct TokyoCityQuiz2App: App {
    @StateObject private var settingViewModel = SettingViewModel()
    @StateObject private var quizViewModel: QuizViewModel
    
    init() {
        // SettingViewModelを先に生成してquestionCountを取得
        let settingVM = SettingViewModel()
        _settingViewModel = StateObject(wrappedValue: settingVM)
        _quizViewModel = StateObject(wrappedValue: QuizViewModel())
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(quizViewModel: quizViewModel)
                .environmentObject(settingViewModel)
        }
    }
}

