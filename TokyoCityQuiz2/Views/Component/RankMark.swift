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
    
    var medalText: Int {
        switch medal {
        case .gold:
            return 1
        case .silver:
            return 2
        case .copper:
            return 3
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [.r_Orange, .r_Purple]),
                                   startPoint: .top,
                                   endPoint: .bottom)
                )
                .frame(width: 40, height: 40)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
            Text("\(medalText)")
                .font(.potta(size: 30))
                .foregroundColor(.white)
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
