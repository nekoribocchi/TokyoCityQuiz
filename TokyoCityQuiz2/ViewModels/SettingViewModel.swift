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
        self.questionCount = UserDefaults.standard.integer(forKey: "questionCount")
    }
}
