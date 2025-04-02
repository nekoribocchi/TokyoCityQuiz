//
//  QuizViewModel.swift
//  TokyoCityQuiz2
//
//  Created by 羽田野真央 on 2025/02/04.
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
    @Published var questionCount: Int
    @Published var lastScore: Score? = nil
    @Published var isAnswerSubmitted: Bool = false
    
    private let scoreManager = ScoreManager()
    private let cityDataProvider = CityDataProvider.shared
    
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
    
    func updateQuestionCount(_ count: Int) {
        self.questionCount = count
        print("updateQuestionCount |\(questionCount)")
    }
    

}


