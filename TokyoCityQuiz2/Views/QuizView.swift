//
//  QuizView.swift
//  TokyoCityQuiz2
//
//  Created by 羽田野真央 on 2025/02/04.
//
import SwiftUI
import GlassmorphismUI

struct QuizView: View {
    @ObservedObject var viewModel: QuizViewModel
    
    var body: some View {
        ZStack{
            RoundedTopBar(text: "第\(viewModel.currentQuestionIndex + 1) 問 /  \(viewModel.questionCount)問中", isGradient: true)
      
            RoundRectangleView(heightRatio: 0.8)
            
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
                GeometryReader { geometry in
                    let topPadding = geometry.size.height / 2
                    let hPadding = geometry.size.width / 10
                Image(viewModel.questions[viewModel.currentQuestionIndex].cityName)
                        .resizable()
                             .aspectRatio(contentMode: .fit)
                             .padding(.horizontal, hPadding)
                             .padding(.top, topPadding)
                             .frame(maxWidth: .infinity, alignment: .center)
                     }

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
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        // 10問でQuizViewを表示
        QuizView(viewModel: QuizViewModel(questionCount: 10))
    }
}

