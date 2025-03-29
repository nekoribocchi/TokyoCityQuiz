//
//  RankingViewModel.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/03/29.
//

import Foundation
 
class ScoreManager {
private let key = "scoreHistory"
    
    func save(score: Int){
        var history = load()
        let newScore = Score(date: Date(), score: score)
        history.append(newScore)

        if let encoded = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
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
