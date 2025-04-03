//
//  NextButton.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/04/03.
//

import SwiftUI
import GlassmorphismUI

struct NextButton: View {
    var action: () -> Void
    
    var body: some View {
        VStack{
            
            HStack{
                Spacer()
                Button(action: {
                    action()
                }) {
                    VStack{
                        Image(systemName: "arrow.forward.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                        
                        Text("次の問題へ")
                            .font(.potta(size: 15))
                            .foregroundColor(.white)
                    }
                    .padding()
                }
                .accessibilityLabel("次の問題へ")
                
            }.padding(10)
            Spacer()
        }.padding(10)
        
    }
}

#Preview {
    ZStack{
        GradientBackground(startColor: .g_Purple, endColor: .g_Orange)
        NextButton(action: {
            print("a")
        })
    }
    
}
