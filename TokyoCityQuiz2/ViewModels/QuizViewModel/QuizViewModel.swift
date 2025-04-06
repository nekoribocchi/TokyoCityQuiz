//
//  QuizViewModel.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/02/04.
//


import Foundation
import SwiftUICore

class QuizViewModel: ObservableObject{
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex: Int = 0
    @Published var score: Int = 0
    @Published var selectedAnswerIndex: Int? = nil
    @Published var answerHistory: [Int] = []
    @Published var isQuizFinished: Bool = false
    @Published var scoreHistory: [Score] = []
    @Published var questionCount: Int = 10
    @Published var lastScore: Score? = nil
    @Published var isAnswerSubmitted: Bool = false
    
    let scoreManager = ScoreManager()
    let cityDataProvider = CityDataProvider.shared
    
    init(){
        self.questionCount = UserDefaults.standard.integer(forKey: "questionCount")
        self.scoreHistory = scoreManager.load()
        self.generateQuestions()
    }
    
    func startNewQuiz(){
        resetQuiz()
        questionCount = UserDefaults.standard.integer(forKey: "questionCount")
        generateQuestions()
    }
    
    func resetQuiz(){
        score = 0
        currentQuestionIndex = 0
        answerHistory = []
        isQuizFinished =  false
    }
    
    func updateQuestionCount(_ count: Int) {
        self.questionCount = count
        print("updateQuestionCount |\(questionCount)")
    }
}


