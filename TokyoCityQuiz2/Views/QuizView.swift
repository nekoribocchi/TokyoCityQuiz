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
    let scoreManager = ScoreManager()
    var body: some View {
        VStack{
          
            if viewModel.isQuizFinished {
                ScoreView(quizViewModel: viewModel)
            } else {
                ZStack{
                    RoundedTopBar(text: "第\(viewModel.currentQuestionIndex + 1) 問 /  \(viewModel.questionCount)問中", isGradient: true)
                    RoundRectangleView(heightRatio: 0.8){
                        VStack{
                            HStack {
                                Spacer(minLength: 0)
                                
                                Image(viewModel.questions[viewModel.currentQuestionIndex].cityName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 600)
                                
                                Spacer(minLength: 0)
                            }
                            .padding(.horizontal, UIScreen.main.bounds.width / 15)
                            
                            Text(viewModel.questions[viewModel.currentQuestionIndex].cityName)
                                .font(.title)
                                .padding()
                            
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
                                
                            }
                        }
                    }
                }
            }
        }
      
        .onAppear {
            if viewModel.questions.isEmpty {
                viewModel.generateQuestions()
            }
        }
    }
}


struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(viewModel: QuizViewModel(questionCount: 3))
    }
}

