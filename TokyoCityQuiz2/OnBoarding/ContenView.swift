//
//  ContenView.swift
//  TokyoCityQuiz2
//
//  Created by 羽田野真央 on 2025/02/26.
//

import SwiftUI

struct ContentView: View {
    @State private var showingOnboarding = true
    
    var body: some View {
        NavigationView {
            Text("Hello, UIOnboarding!")
                .toolbar {
                    Button {
                        showingOnboarding = true
                    } label: {
                        Image(systemName: "repeat")
                    }
                }
                .fullScreenCover(isPresented: $showingOnboarding, content: {
                    OnboardingView.init(onboardingCompleted: {
                        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                        showingOnboarding = false
                    })
                    .edgesIgnoringSafeArea(.all)
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView.init()
    }
}




