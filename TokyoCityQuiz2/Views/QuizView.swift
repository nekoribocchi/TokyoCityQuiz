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
    @State var isShowHome: Bool = false
    let scoreManager = ScoreManager()
    let cityDataProvider = CityDataProvider.shared
    
    var body: some View {
        NavigationStack{
            VStack{
                if viewModel.isQuizFinished {
                    ScoreView(quizViewModel: viewModel)
                } else {
                    ZStack{
                        RoundedTopBar(text: "第\(viewModel.currentQuestionIndex + 1) 問 /  \(viewModel.questionCount)問中", isGradient: true)
                        RoundRectangleView(heightRatio: 0.85){
                            VStack{
                                HStack {
                                    Spacer(minLength: 0)
                                    
                                    /*
                                     Image(viewModel.questions[viewModel.currentQuestionIndex].cityName)
                                     .resizable()
                                     .aspectRatio(contentMode: .fit)
                                     .frame(maxWidth: 600)
                                     */
                                    Image("i")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 700)
                                    
                                    Spacer(minLength: 0)
                                }
                                .padding(.horizontal, UIScreen.main.bounds.width / 15)
                                
                                //                            Text(viewModel.questions[viewModel.currentQuestionIndex].cityName)
                                //                                .font(.title)
                                //                                .padding()
                                //
                                ForEach(0..<4) { index in
                                    ButtonBase.simple(title: viewModel.questions[viewModel.currentQuestionIndex].options[index],
                                                      backgroundColor: .white,
                                                      textColor: .r_Purple,
                                                      font: "PottaOne-Regular",
                                                      isFurigana: true,
                                                      furigana: cityDataProvider.furigana(for:viewModel.questions[viewModel.currentQuestionIndex].options[index] ) ?? "",
                                                      action: {
                                        viewModel.selectAnswer(index: index)
                                    })
                                    .padding(5)
                                    
                                }
                            }
                        }
                        BackButton{
                            isShowHome = true
                        }
                        
                    }
                }
            }
        }.navigationDestination(isPresented: $isShowHome){
            MainView()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if viewModel.questions.isEmpty {
                viewModel.generateQuestions()
            }
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(
            viewModel: QuizViewModel(questionCount: 3)
        )
    }
}
