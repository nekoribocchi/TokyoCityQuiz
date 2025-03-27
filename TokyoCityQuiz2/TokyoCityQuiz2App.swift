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
    
    var body: some Scene {
        
        WindowGroup {
            
            if hasCompletedOnboarding {
                MainView() // 通常の画面へ
            } else {
                OnboardingView(onboardingCompleted: {
                    UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                    hasCompletedOnboarding = true // 画面を切り替える
                })
            }
        }
           
    }
}
