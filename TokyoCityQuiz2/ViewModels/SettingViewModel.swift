//
//  SettingViewModel.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/04/01.
//

import Foundation

class SettingViewModel: ObservableObject {
    @Published var questionCount: Int {
        didSet {
            UserDefaults.standard.set(questionCount, forKey: "questionCount")
        }
    }
    
    init() {
        let storedCount = UserDefaults.standard.object(forKey: "questionCount") as? Int
        
        if let count = storedCount {
            self.questionCount = count
        } else {
            self.questionCount = 10
            UserDefaults.standard.set(10, forKey: "questionCount")
        }
    }
}

