//
//  SettingView.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/03/27.
//

import SwiftUI
import GlassmorphismUI

struct SettingView: View {
    @ObservedObject var viewModel: QuizViewModel
    @State var isShowQuiz: Bool = false
    @State private var volume: Double = 0.5
    let sumQuestion: [Int] = [5,10,15,20,30]
    var body: some View {
        NavigationStack{
            ZStack {
                RoundedTopBar(text: "設定", isGradient: true)
                BackButton()
                RoundRectangleView(heightRatio: 0.8){
                    
                    VStack {
                        Text("問題数")
                            .font(.potta(size: 20))
                        
                        Picker("問題数", selection: $viewModel.questionCount) {
                            ForEach(sumQuestion, id: \.self) { count in
                                Text("\(count)問")
                                
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.bottom, 15)
                        
                        Text("BGM")
                            .font(.potta(size: 20))
                        HStack {
                            Image(systemName: "speaker.fill")
                            VolumeSliderView(value: $volume)
                            Image(systemName: "speaker.wave.3.fill")
                        }
                        Spacer()
                        ButtonBase.simple(title: "遊ぶ", font: "PottaOne-Regular", isFurigana: true, furigana: "あそぶ") {
                            isShowQuiz = true
                        }
                    }
                    
                    
                }
                .navigationBarBackButtonHidden(true)
                .padding()
            }
            
        }
        .navigationDestination(isPresented: $isShowQuiz){
            QuizView(viewModel: viewModel)
        }
    }
}



#Preview {
    SettingView(viewModel: QuizViewModel(questionCount: 2))
}
