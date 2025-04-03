//
//  NextQuizButton.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/04/02.
//

import SwiftUI

struct NextQuizButton: View {
    var action: () -> Void
    let offsetY: CGFloat = isTouchIDDevice() ? 10 : 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                Button(action: action){
                    ZStack (){
                        HalfCircle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.g_Orange, .g_Purple]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(width: geometry.size.height * 0.3, height: 220)
                            .shadow(radius: 5)
                            .position(
                                x: geometry.size.width / 2,
                                y: geometry.size.height - geometry.size.height * 0.04 + offsetY
                            )
                        
                        VStack{
                            Spacer()
                            Text("次へ")
                                .foregroundColor(.white)
                                .font(.potta(size: 20))
                                .padding(10)
                        }
                    }
                    .contentShape(HalfCircle())
                }
            }
            .ignoresSafeArea(edges: .bottom)
            
        }
    }
}

import LocalAuthentication

func isTouchIDDevice() -> Bool {
    let context = LAContext()
    var error: NSError?
    let canEvaluate = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    return canEvaluate && context.biometryType == .touchID
}

struct HalfCircle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.maxY),
            radius: rect.width / 2,
            startAngle: .degrees(180),
            endAngle: .degrees(360),
            clockwise: false
        )
        path.addLine(to: CGPoint(x: rect.midX + rect.width / 2, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX - rect.width / 2, y: rect.maxY))
        return path
    }
}

#Preview {
    NextQuizButton {
        print("つぎへ！")
    }
}
