//
//  PickerView.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/04/01.
//

import SwiftUI

struct PickerView: View {
    @State private var volume: Double = {
        let savedVolume = UserDefaults.standard.double(forKey: "bgmVolume")
        return savedVolume == 0.0 ? 0.5 : savedVolume
    }()

    @Binding var selected: Int
    let options: [Int]
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(options, id: \.self) { option in
                Text("\(option)問")
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(
                        LinearGradient(
                            colors: selected == option ?
                                [Color.orange, Color.pink] :
                                [Color(.systemGray5), Color(.systemGray4)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .foregroundColor(selected == option ? .white : .black)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                    .onTapGesture {
                        selected = option
                    }
            }
        }
    }
}
