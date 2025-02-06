//
//  ContentView.swift
//  TokyoCityQuiz2
//
//  Created by 羽田野真央 on 2025/02/04.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        VStack{
            NavigationStack{
                NavigationLink("START", destination: QuizView())
                NavigationLink("RNKING", destination: RankingView())
            }
            
            
         
        }
    }
}
 
#Preview {
    MainView()
}
