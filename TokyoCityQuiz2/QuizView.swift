//
//  QuizView.swift
//  TokyoCityQuiz2
//
//  Created by 羽田野真央 on 2025/02/04.
//

import SwiftUI

struct QuizView: View {
    @StateObject private var quizViewModel = QuizViewModel()
    
    var body: some View {
        VStack(spacing:  20){
            Text("この区市町村名はどこ？")
            
/*options: ["国立市","東村山市","豊島区","練馬区"],

We use 'indeces' because we want the 'index' variable to hold the numeric index value, not the string.
      */
            
            ForEach(quizViewModel.quiz[0].options.indices, id:\.self){ index in
                Button(action: {
                    quizViewModel.selectedAnsewer(index)
                    //the method hold this code 'selectedAnswerIndex = index'
                }){
                    Text(quizViewModel.quiz[0].options[index])
                        .padding(25)
                        .frame(maxWidth: .infinity)
                        .background(buttonBackgroundColor(index))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .disabled(quizViewModel.isAnswered)
                .padding(.horizontal,20)
            }
        }
    }
    
    //The index indicates options of Answer.
    private func buttonBackgroundColor(_ index: Int) -> Color {
        guard quizViewModel.isAnswered else{
            return .blue
        }
        if index == quizViewModel.quiz[0].correctAnswerIndex {
            return .green
        }
        else if  index == quizViewModel.selectedAnswerIndex {
            return .red
        }
        return .blue
    }
    

}


#Preview {
    QuizView()
}
