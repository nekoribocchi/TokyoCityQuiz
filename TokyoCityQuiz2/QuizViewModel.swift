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
    var citiesArray: [String] = []
    
    
    init(){
        if let filePath = Bundle.main.path(forResource: "city", ofType: "csv") {
            let allBundles = Bundle.allBundles

        }
                print(citiesArray)
    }
    

    func selectedAnsewer(_ index: Int){
        selectedAnswerIndex = index
        isAnswered = true
    }
    
    func parseCitiesFromCSV(csvString: String) -> [String] {
        let rows = csvString.components(separatedBy: .newlines)
        return rows.dropFirst().compactMap { row in
            let columns = row.components(separatedBy: ",")
            return columns.count > 1 ? columns[1] : nil
        }
    }
}
