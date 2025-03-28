//
//  QuizView.swift
//  TokyoCityQuiz2
//
//  Created by 羽田野真央 on 2025/02/04.
//
import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: QuizViewModel
    
    var body: some View {
        VStack {
            if viewModel.isQuizFinished {
                // クイズ終了後のスコア画面
                Text("あなたのスコアは \(viewModel.score) 点です")
                    .font(.largeTitle)
                    .padding()
                
                Button("ランキングを見る") {
                    // ランキング画面へ遷移
                }
            } else {
                // 現在の問題
                Text("問題 \(viewModel.currentQuestionIndex + 1) / \(viewModel.questions.count)")
                    .font(.title2)
                    .padding()
                
                // クイズの問題（都市名を表示）
                Text(viewModel.questions[viewModel.currentQuestionIndex].cityName)
                    .font(.title)
                    .padding()
                
                // 選択肢のボタンを表示
                ForEach(0..<4) { index in
                    Button(action: {
                        viewModel.selectAnswer(index: index)
                    }) {
                        Text(viewModel.questions[viewModel.currentQuestionIndex].options[index])
                            .font(.title2)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(5)
                }
                
                // 現在選択している答え
                if let selectedIndex = viewModel.selectedAnswerIndex {
                    Text("あなたの選択: \(viewModel.questions[viewModel.currentQuestionIndex].options[selectedIndex])")
                        .padding()
                }
            }
        }
        .padding()
        .onAppear {
            // クイズ開始時に問題を生成する
            if viewModel.questions.isEmpty {
                viewModel.generateQuestions()
            }
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        // 10問でQuizViewを表示
        QuizView(viewModel: QuizViewModel(questionCount: 10))
    }
}
