//
//  Score.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/03/28.
//

import Foundation
struct Score :Encodable,Decodable{
    let date: Date
    let score: Int
}
