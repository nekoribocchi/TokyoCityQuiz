//
//  BackButton.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/03/31.
//

import SwiftUI
import GlassmorphismUI

private struct IsInQuizKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

extension EnvironmentValues {
    var isInQuiz: Bool {
        get { self[IsInQuizKey.self] }
        set { self[IsInQuizKey.self] = newValue }
    }
}


struct BackButton: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.isInQuiz) private var isInQuiz
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
                    if isInQuiz{
                        VStack{
                            Image(systemName: "xmark.circle")
                                .font(.system(size: 50))
                                .foregroundColor(.white)
                            Text("中断する")
                                .font(.potta(size: 15))
                                .foregroundColor(.white)
                        }
                    }else{
                        Image(systemName: "arrow.backward.circle")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                    }
                        
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
