//
//  BackButton.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/03/31.
//

import SwiftUI
import GlassmorphismUI

struct BackButton: View {
    @Environment(\.dismiss) private var dismiss
    var action: (() -> Void)? = nil

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    if let action = action {
                        action()
                    } else {
                        dismiss()
                    }
                }) {
                    Image(systemName: "arrow.backward.circle")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                }
                .padding(30)
                Spacer()
            }
            Spacer()
        }
    }
}

#Preview {
    ZStack {
        GradientBackground(startColor: .red, endColor: .purple)
        BackButton()
    }
}
