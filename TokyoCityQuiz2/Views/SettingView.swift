//
//  SettingView.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/03/27.
//

import SwiftUI
import GlassmorphismUI

class SettingViewModel: ObservableObject {
    @Published var questionCount: Int {
        didSet {
            UserDefaults.standard.set(questionCount, forKey: "questionCount")
        }
    }
    
    init() {
        self.questionCount = UserDefaults.standard.integer(forKey: "questionCount")
        if self.questionCount == 0 {
                    self.questionCount = 5
                }
    }
}


struct SettingView: View {
    @ObservedObject var quizViewModel: QuizViewModel
    @State var isShowQuiz: Bool = false
    @State private var volume: Double = 0.5
    @EnvironmentObject var settingViewModel: SettingViewModel
    
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
                        
                        Picker("問題数", selection: $settingViewModel.questionCount) {
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
                            quizViewModel.updateQuestionCount(settingViewModel.questionCount)
                        }
                    }
                    
                    
                }
                .navigationBarBackButtonHidden(true)
                .padding()
            }
            
        }
        .navigationDestination(isPresented: $isShowQuiz){
            QuizView(viewModel: quizViewModel)
        }
    }
}



#Preview {
    let settingViewModel = SettingViewModel()
    let quizViewModel = QuizViewModel(questionCount: settingViewModel.questionCount)
    return SettingView(quizViewModel: quizViewModel)
        .environmentObject(settingViewModel)
}
