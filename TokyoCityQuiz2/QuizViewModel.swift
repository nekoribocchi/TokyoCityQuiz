//
//  QuizViewModel.swift
//  TokyoCityQuiz2
//
//  Created by 羽田野真央 on 2025/02/04.
//


import Foundation

class QuizViewModel: ObservableObject{
    @Published var isAnswered = false
    @Published var selectedAnswerIndex: Int?
    
    var quiz:[Quiz] =
    [Quiz(options: ["国立市","東村山市","豊島区","練馬区"], correctAnswerIndex: 1, image: "1.png"),
     Quiz(options: ["国立市","東村山市","豊島区","練馬区"], correctAnswerIndex: 1, image: "1.png"),
     ]
    
    var isCorrect: Bool{
        selectedAnswerIndex == quiz[0].correctAnswerIndex
    }
    
    func selectedAnsewer(_ index: Int){
        selectedAnswerIndex = index
        isAnswered = true
    }
  
    
}
