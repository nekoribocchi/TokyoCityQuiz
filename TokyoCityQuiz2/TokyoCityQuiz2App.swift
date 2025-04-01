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
    @StateObject private var quizViewModel = QuizViewModel()
    
    var body: some Scene {
        WindowGroup {
            
            if hasCompletedOnboarding {
                MainView(quizViewModel: quizViewModel) 
            } else {
                OnboardingView(onboardingCompleted: {
                    UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                    hasCompletedOnboarding.toggle()
                })
            }
        }
           
    }
}
