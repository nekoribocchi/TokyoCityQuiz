//
//  QuizViewModel.swift
//  TokyoCityQuiz2
//
//  Created by 羽田野真央 on 2025/02/04.
//


import Foundation

class QuizViewModel: ObservableObject{
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex: Int = 0
    @Published var score: Int = 0
    @Published var selectedAnswerIndex: Int? = nil
    @Published var answerHistory: [Int] = []
    @Published var isQuizFinished: Bool = false
    @Published var scoreHistory: [Score] = []
    @Published var questionCount: Int
    private let scoreManager = ScoreManager()
    
    init(questionCount: Int){
        self.questionCount = questionCount
        self.scoreHistory = scoreManager.load()
        self.generateQuestions()
    }
    
    func generateQuestions(){
        let cityData = [
            "八王子市", "立川市", "武蔵野市", "三鷹市", "青梅市", "府中市", "昭島市", "調布市", "町田市", "小金井市",
            "小平市", "日野市", "東村山市", "国分寺市", "国立市", "福生市", "狛江市", "東大和市", "清瀬市", "東久留米市",
            "武蔵村山市", "多摩市", "稲城市", "羽村市", "あきる野市", "西東京市", "瑞穂町", "日の出町", "檜原村", "奥多摩町",
            "千代田区", "中央区", "港区", "新宿区", "文京区", "台東区", "墨田区", "江東区", "品川区", "目黒区", "大田区",
            "世田谷区", "渋谷区", "中野区", "杉並区", "豊島区", "北区", "荒川区", "板橋区", "練馬区", "足立区", "葛飾区", "江戸川区"
        ]
        
        var allQuestions: [Question] = []
        
        for city in cityData.shuffled().prefix(questionCount){
            let options = Array(cityData.shuffled().prefix(4))
            
            let correctAnswerIndex = Int.random(in: 0..<4)
            
            var finalOptions = options
            finalOptions[correctAnswerIndex] = city
            
            let question = Question(cityName: city, imageName: city, options: finalOptions, correctAnswerIndex: correctAnswerIndex)
            
            allQuestions.append(question)
        }
        self.questions = allQuestions
    }
    
    func selectAnswer(index: Int){
        selectedAnswerIndex = index
        answerHistory.append(index)
        
        if index == questions[currentQuestionIndex].correctAnswerIndex{
            score += 1
        }
        
        currentQuestionIndex += 1
        if currentQuestionIndex >= questions.count{
            finishQuiz()
        }
    }
    
    func finishQuiz(){
        isQuizFinished = true
        scoreManager.save(score: score)
    }
    
    func resetQuiz(){
        score = 0
        currentQuestionIndex = 0
        answerHistory = []
        isQuizFinished = false
        generateQuestions()
    }
    
    
}


