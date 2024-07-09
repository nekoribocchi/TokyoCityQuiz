//
//  YellowButton.swift
//  QuizApp_YouTube
//
//  Created by 羽田野真央 on 2024/02/15.
//
import UIKit

class YellowButton: QBButton {
    
    override func setupButton() {
        super.setupButton() // Call the setupButton() method from the parent class
        
        // Customize the appearance for BlueButton
        setTitleColor(.orange, for: .normal)
        backgroundColor = UIColor.systemYellow
        layer.borderColor = UIColor.systemYellow.cgColor
        layer.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.1).cgColor
        layer.shadowColor = UIColor.systemYellow.cgColor
    }
}

#Preview {
    YellowButton()
}
