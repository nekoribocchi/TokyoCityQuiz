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
                        RoundedTopBar(isGradient: true){
                            VStack{
                                Text("第\(viewModel.currentQuestionIndex + 1)問")
                                    .font(.potta(size: 25))
                                    .foregroundColor(.white)
                                Text("\(viewModel.questionCount)問中")
                                    .foregroundColor(.white)
                                    .font(.potta(size: 15))
                            }
                        }
                        RoundRectangleView(heightRatio: 0.85){
                            VStack{
                                HStack {
                                    Spacer(minLength: 0)
 
                                    Image("\(viewModel.questions[viewModel.currentQuestionIndex].cityName)")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 700)
                                    
                                    Spacer(minLength: 0)
                                }
                                .padding(.horizontal, UIScreen.main.bounds.width / 15)
                                
                                ForEach(0..<4) { index in
                                    ButtonBase.icon( title: viewModel.questions[viewModel.currentQuestionIndex].options[index],
                                                      backgroundColor: viewModel.getButtonColor(for: index),
                                                      textColor: viewModel.getButtonFontColor(for: index),
                                                      font: "PottaOne-Regular",
                                                      isFurigana: true,
                                                      furigana: cityDataProvider.furigana(for:viewModel.questions[viewModel.currentQuestionIndex].options[index] ) ?? "",
                                                     iconName:viewModel.getButtonIcon(for: index) ?? "",
                                                      action: {
                                        viewModel.selectAnswer(index: index)
                                        viewModel.isAnswerSubmitted = true
                                    })
                                    .padding(5)
                                }
                            }
                        }
                        BackButton{
                            isShowHome = true
                            viewModel.resetQuiz()
                        }
                        
                            if viewModel.isAnswerSubmitted{
                                NextQuizButton{
                                viewModel.goToNextQuestion()
                            }
                        }
                    }
                }
            }
        }.navigationDestination(isPresented: $isShowHome){
            MainView()
        }
        .navigationBarBackButtonHidden(true)
       
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = QuizViewModel()
        viewModel.questions = [
            Question(cityName: "渋谷区", imageName: "渋谷区", options: ["渋谷区", "新宿区", "港区", "千代田区"], correctAnswerIndex: 0)
        ]
        return QuizView(viewModel: viewModel)
    }
}

