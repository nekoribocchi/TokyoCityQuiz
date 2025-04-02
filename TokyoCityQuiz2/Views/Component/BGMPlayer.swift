//
//  BGMPlayer.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/04/02.
//
import Foundation
import AVFoundation

class BGMPlayer {
    static let shared = BGMPlayer()
    
    var player: AVAudioPlayer?

    func playBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "p", withExtension: "mp3") else {
            print("❌ 音楽ファイルが見つからないよ！")
            return
        }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1 // 無限ループ
            player?.prepareToPlay()
            player?.volume = Float(UserDefaults.standard.double(forKey: "bgmVolume"))
            player?.play()

            print("✅ 音楽再生スタート！")
        } catch {
            print("❌ 音楽再生に失敗: \(error)")
        }
    }
    
    func stopBackgroundMusic() {
        player?.stop()
    }
    
    func setVolume(_ volume: Double) {
            player?.volume = Float(volume)
            UserDefaults.standard.set(volume, forKey: "bgmVolume")
        }
}
