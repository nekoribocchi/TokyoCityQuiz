//
//  RankingViewModel.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/03/29.
//

import Foundation
import SwiftUICore
 
struct ScoreManager {
private let key = "scoreHistory"
    
    func save(score: Int, questionCount: Int){
        var history = load()
        let newScore = Score(date: Date(), score: calculateScore(score: score, questionCount: questionCount))
        history.append(newScore)

        if let encoded = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func calculateScore(score: Int, questionCount: Int) -> Int{
        var finalScore: Int
        finalScore = Int((Double(score) / Double(questionCount) * 100).rounded())
        return finalScore
    }
    
    func load() -> [Score]{
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Score].self, from: data) {
            return decoded
        }
        return []
    }
    
    func getTopScores() -> [Score]{
        return load().sorted{
            $0.score > $1.score
        }
    }
    
}
