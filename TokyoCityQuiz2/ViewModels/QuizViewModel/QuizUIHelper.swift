//
//  QuizUIHelper.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/04/04.
//

import SwiftUI

extension QuizViewModel{
    func getButtonColor(for index: Int)  -> Color{
        guard isAnswerSubmitted else {
            return .white
        }
        
        let correct = questions[currentQuestionIndex].correctAnswerIndex
        
        if index == correct {
            return .r_Orange
        }else if index == selectedAnswerIndex {
            return .r_Purple
        }else{
            return .white
        }
    }
    
    func getButtonFontColor(for index: Int)  -> Color{
        guard isAnswerSubmitted else {
            return .r_Purple
        }
        
        let correct = questions[currentQuestionIndex].correctAnswerIndex
        
        if index == correct || index == selectedAnswerIndex {
            return .white
        }else{
            return .r_Purple
        }
    }
    
    func getButtonIcon(for index: Int) -> String? {
        guard isAnswerSubmitted else {
            return ""
        }
        
        let correct = questions[currentQuestionIndex].correctAnswerIndex
        if index == correct {
            return "checkmark"
        }else if index == selectedAnswerIndex {
            return "xmark"
        }else{
            return nil
        }
    }
}
