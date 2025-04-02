//
//  SettingView.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/03/27.
//

import SwiftUI
import GlassmorphismUI

struct SettingView: View {
    @State var quizViewModel: QuizViewModel
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
                        .onChange(of: settingViewModel.questionCount, initial: true){ oldValue, newValue in
                            print("新しい値に変わった　old :\(oldValue) new:\(newValue)")
                            print(UserDefaults.standard.integer(forKey: "questionCount"))
                            quizViewModel.updateQuestionCount(newValue)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.bottom, 15)
                        
                        Text("BGM")
                            .font(.potta(size: 20))
                        HStack {
                            Image(systemName: "speaker.fill")
                            VolumeSliderView(value: $volume)
                                .onChange(of: volume) { oldValue, newValue in
                                    UserDefaults.standard.set(newValue, forKey: "bgmVolume")
                                    BGMPlayer.shared.setVolume(newValue)
                                    print("音量を保存しました: \(newValue)")
                                }

                            Image(systemName: "speaker.wave.3.fill")
                        }
                        Spacer()
                        ButtonBase.simple(title: "遊ぶ", font: "PottaOne-Regular", isFurigana: true, furigana: "あそぶ") {
                            isShowQuiz = true
                            quizViewModel = QuizViewModel()
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
                .padding()
            }
        }
        .navigationDestination(isPresented: $isShowQuiz) {
            QuizView(viewModel: quizViewModel)
        }
    }
}

