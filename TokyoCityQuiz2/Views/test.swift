//
//  test.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/04/02.
//

import SwiftUI

import SwiftUI
import UIKit  // 振動を使うために必要！

struct test: View {
    var body: some View {
        Button("押してね") {
            // バイブレーションするコード
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
        .padding()
        .font(.title)
    }
}


#Preview {
    test()
}
