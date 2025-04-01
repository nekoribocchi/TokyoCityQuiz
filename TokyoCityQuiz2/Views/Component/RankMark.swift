//
//  RankMark.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/04/01.
//

import SwiftUI

struct RankMark: View {
    enum Medal {
        case gold
        case silver
        case copper
    }
    
    var medal: Medal
    
    var medalColor: Color {
        switch medal {
        case .gold:
            return .yellow
        case .silver:
            return .gray
        case .copper:
            return .brown
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    AngularGradient(
                        gradient: Gradient(colors: [medalColor, medalColor.opacity(0.7)]),
                        center: .center,
                        angle: .degrees(270)
                    )
                )
                .frame(width: 40, height: 40)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
            
//            Image(systemName: "medal")
//                .font(.system(size: 20, weight: .bold))
//                .foregroundColor(.white)
                    }
    }
}

struct RankMark_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            RankMark(medal: .gold)
            RankMark(medal: .silver)
            RankMark(medal: .copper)
        }
    }
}
