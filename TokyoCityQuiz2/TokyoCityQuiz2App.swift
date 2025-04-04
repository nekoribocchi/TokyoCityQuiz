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
    @StateObject private var quizViewModel = QuizViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView(quizViewModel: quizViewModel)
                .environmentObject(settingViewModel)
        }
    }
}
