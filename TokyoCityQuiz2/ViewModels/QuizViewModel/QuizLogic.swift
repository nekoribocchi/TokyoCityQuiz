//
//  QuizLogic.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/04/04.
//

import SwiftUI

extension QuizViewModel{
    func generateQuestions(){
        let cityName = Array(cityDataProvider.cityData.keys)
        var allQuestions: [Question] = []
        
        for city in cityName.shuffled().prefix(questionCount){
            let options = Array(cityName.shuffled().prefix(4))
            
            let correctAnswerIndex = Int.random(in: 0..<4)
            
            var finalOptions = options
            finalOptions[correctAnswerIndex] = city
            
            let question = Question(cityName: city, imageName: city, options: finalOptions, correctAnswerIndex: correctAnswerIndex)
            
            allQuestions.append(question)
        }
        self.questions = allQuestions
    }
    
    func selectAnswer(index: Int){
        if isAnswerSubmitted {
            return
        }
        
        selectedAnswerIndex = index
        answerHistory.append(index)
        
        if index == questions[currentQuestionIndex].correctAnswerIndex{
            score += 1
        }
        
        isAnswerSubmitted = true
    }
    
    func goToNextQuestion(){
        selectedAnswerIndex = nil
        isAnswerSubmitted = false
        currentQuestionIndex += 1
        
        if currentQuestionIndex >= questions.count {
            finishQuiz()
        }
    }
    
    func finishQuiz(){
        isQuizFinished = true
        lastScore = Score(date: Date(), score: scoreManager.calculateScore(score: score, questionCount: questionCount))
        scoreManager.save(score: score,questionCount: questionCount)
    }
}
