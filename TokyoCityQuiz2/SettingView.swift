//
//  SettingView.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/03/27.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: QuizViewModel

    var body: some View {
        VStack {
            Text("問題数を選択してください")
            
            Picker("問題数", selection: $viewModel.questionCount) {
                ForEach(5..<21) { count in
                    Text("\(count)問")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Button("クイズを開始") {
                // クイズ画面へ遷移
            }
        }
        .padding()
    }
}

#Preview {
    
    SettingsView(viewModel: QuizViewModel(questionCount: 2))
}
