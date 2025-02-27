//
//  UIOnboardingHelper.swift
//  TokyoCityQuiz2
//
//  Created by 羽田野真央 on 2025/02/26.
//

import Foundation
import UIKit
import UIOnboarding

struct UIOnboardingHelper {
    // App Icon
    static func setUpIcon() -> UIImage {
        return Bundle.main.appIcon ?? .init(named: "onboarding-icon") ?? UIImage()
    }

    // First Title Line
    // Welcome Text
    static func setUpFirstTitleLine() -> NSMutableAttributedString {
        .init(string: "ようこそ！", attributes: [.foregroundColor: UIColor.label])
    }
    
    // Second Title Line
    // App Name
    static func setUpSecondTitleLine() -> NSMutableAttributedString {
        .init(string: Bundle.main.displayName ?? "都内区市町村クイズへ", attributes: [
            .foregroundColor: UIColor.init(named: "camou")!
        ])
    }

    // Core Features
    static func setUpFeatures() -> Array<UIOnboardingFeature> {
        return .init([
            .init(icon: .init(named: "feature-1")!,
                  title: "視覚で覚える",
                  description: "地図画像とともに区市町村名を覚えられます"),
            .init(icon: .init(named: "feature-2")!,
                  title: "ゲーム感覚でモチベーションアップ",
                  description: "ゲームのような没入感でクイズを楽しみます"),
            .init(icon: .init(named: "feature-3")!,
                  title: "美しいデザイン",
                  description: "デザインにこだわりました")
        ])
    }

    
    // Notice Text
    static func setUpNotice() -> UIOnboardingTextViewConfiguration {
        return .init(icon: .init(named: "onboarding-notice-icon")!,
                     text: "Developed and designed for members of the Swiss Armed Forces.",
                     linkTitle: "Learn more...",
                     link: " ",
                     tint: .init(named: "camou"))
    }

    // Continuation Title
    static func setUpButton() -> UIOnboardingButtonConfiguration {
        return .init(title: "始める",
                     titleColor: .white, // Optional, `.white` by default
                     backgroundColor: .init(named: "camou")!)
    }
}


extension UIOnboardingViewConfiguration {
    // UIOnboardingViewController init
    static func setUp() -> UIOnboardingViewConfiguration {
        return .init(appIcon: UIOnboardingHelper.setUpIcon(),
                     firstTitleLine: UIOnboardingHelper.setUpFirstTitleLine(),
                     secondTitleLine: UIOnboardingHelper.setUpSecondTitleLine(),
                     features: UIOnboardingHelper.setUpFeatures(),
                     textViewConfiguration: UIOnboardingHelper.setUpNotice(),
                     buttonConfiguration: UIOnboardingHelper.setUpButton())
    }
}

