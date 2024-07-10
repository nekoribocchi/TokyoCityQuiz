import UIKit
import SwiftUI

// クイズ画面を表示するViewController
class QuizViewController: UIViewController {
    
    // クイズ番号のラベル
    @IBOutlet weak var quizNumberLabel: UILabel!
    //@IBOutlet weak var quizTextView: UITextView!
    
    // 選択肢ボタン
    @IBOutlet var answerButton1: UIButton!
    @IBOutlet var answerButton2: UIButton!
    @IBOutlet var answerButton3: UIButton!
    @IBOutlet var answerButton4: UIButton!
    // 正誤判定画像を表示するビュー
    @IBOutlet weak var judgeImageView: UIImageView!
    // クイズ画像を表示するビュー
    @IBOutlet weak var quizImageView: UIImageView!
    
    // 全選択肢ボタンの配列
    @IBOutlet var choiceButtons: [UIButton]!
    
    // CSVデータを格納する配列
    var csvArray: [String] = []
    // クイズデータを格納する配列
    var quizArray: [String] = []
    // 現在のクイズ番号
    var quizCount = 0
    // 正解数
    var correctCount = 0
    // ベストスコア
    var bestScore = 0
    // ボタンの初期背景色を保存する辞書
    var initialButtonColors: [Int: UIColor] = [:]
    
    // ポートレートモードをサポート
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
    }

    // 画面を表示した時に呼ばれる
    override func viewDidLoad() {
       // resetBestScores()
        self.overrideUserInterfaceStyle = .light
        super.viewDidLoad()
        
        // ボタンの初期の背景色を保存
        initialButtonColors = [
            1: answerButton1.backgroundColor ?? UIColor.systemPink,
            2: answerButton2.backgroundColor ?? UIColor.systemPink,
            3: answerButton3.backgroundColor ?? UIColor.systemPink,
            4: answerButton4.backgroundColor ?? UIColor.systemPink
        ]
        
        // CSVファイルのデータを読み込む
        csvArray = loadCSV(fileName: "tama")
        
        // 最初のクイズデータを設定
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        
        // クイズ番号を表示
        quizNumberLabel.text = "第\(quizCount+1)問"
        
        // 画像を表示
        let quizImageName = "\(quizArray[6])"
        if let quizImage = UIImage(named: quizImageName) {
            quizImageView.image = quizImage
        } else {
            print("Image not found: \(quizImageName)")
        }
        
        // 選択肢を表示
        answerButton1.setTitle(quizArray[2], for: .normal)
        answerButton2.setTitle(quizArray[3], for: .normal)
        answerButton3.setTitle(quizArray[4], for: .normal)
        answerButton4.setTitle(quizArray[5], for: .normal)
        
        // ベストスコアを取得・保存
        saveBestScore()
    }
    
    // ScoreViewControllerに遷移するときデータを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toScoreVC" {
            let scoreVC = segue.destination as! ScoreViewController
            scoreVC.correctCount = correctCount
        }
    }
    
    // 選択肢ボタンを押した時に呼ばれる
    @IBAction func btnAction(sender: UIButton){
        if sender.tag == Int(quizArray[1]){
            print("正解")
            correctCount += 1
            judgeImageView.image = UIImage (named: "correct")
        } else {
            print("不正解")
            judgeImageView.image = UIImage(named: "incorrect")
            sender.layer.backgroundColor = UIColor.mypink.withAlphaComponent(0.5).cgColor
            sender.layer.shadowColor = UIColor.mypink.cgColor
            
            // 1秒後にボタンの色を元に戻す
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if let initialColor = self.initialButtonColors[sender.tag] {
                    sender.layer.backgroundColor = initialColor.cgColor
                    sender.layer.shadowColor =  UIColor.black.cgColor
                }
            }
        }
        
        // 正解ボタンの色を変更し、1秒後に元に戻す
        switch Int(quizArray[1]){
        case 1:
            if let initialColor = initialButtonColors[1] {
                answerButton1.layer.backgroundColor = UIColor.mymint.withAlphaComponent(0.7).cgColor
                self.answerButton1.layer.shadowColor = UIColor.mymint.cgColor
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.answerButton1.backgroundColor = initialColor
                    self.answerButton1.layer.shadowColor =  UIColor.black.cgColor
                }
            }
        case 2:
            if let initialColor = initialButtonColors[2] {
                answerButton2.layer.backgroundColor = UIColor.mymint.withAlphaComponent(0.7).cgColor
                self.answerButton2.layer.shadowColor = UIColor.mymint.cgColor
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.answerButton2.backgroundColor = initialColor
                    self.answerButton2.layer.shadowColor =  UIColor.black.cgColor
                }
            }
        case 3:
            if let initialColor = initialButtonColors[3] {
                answerButton3.layer.backgroundColor = UIColor.mymint.withAlphaComponent(0.7).cgColor
                self.answerButton3.layer.shadowColor = UIColor.mymint.cgColor
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.answerButton3.backgroundColor = initialColor
                    self.answerButton3.layer.shadowColor =  UIColor.black.cgColor
                }
            }
        case 4:
            if let initialColor = initialButtonColors[4] {
                answerButton4.layer.backgroundColor = UIColor.mymint.withAlphaComponent(0.7).cgColor
                self.answerButton4.layer.shadowColor = UIColor.mymint.cgColor
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.answerButton4.backgroundColor = initialColor
                    self.answerButton4.layer.shadowColor =  UIColor.black.cgColor
                }
            }
        default:
            break
        }
        
        print("スコア: \(correctCount)")
        
        // 正誤判定画像を表示
        judgeImageView.isHidden = false
        
        // 選択肢ボタンを無効化
        answerButton1.isEnabled = false
        answerButton2.isEnabled = false
        answerButton3.isEnabled = false
        answerButton4.isEnabled = false
        
        // 0.5秒後に正誤判定画像を隠し、ボタンを有効化し、次のクイズへ遷移
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.judgeImageView.isHidden = true
            self.answerButton1.isEnabled = true
            self.answerButton2.isEnabled = true
            self.answerButton3.isEnabled = true
            self.answerButton4.isEnabled = true
            self.nextQuiz()
            self.saveBestScore()
        }
    }
    
    func nextQuiz(){
        quizCount += 1
        if quizCount < 3 {
            quizArray = csvArray[quizCount].components(separatedBy: ",")
            
            quizNumberLabel.text = "第\(quizCount+1)問"
            answerButton1.setTitle(quizArray[2], for: .normal)
            answerButton2.setTitle(quizArray[3], for: .normal)
            answerButton3.setTitle(quizArray[4], for: .normal)
            answerButton4.setTitle(quizArray[5], for: .normal)
            
            let quizImageName = "\(quizArray[6])"
            if let quizImage = UIImage(named: quizImageName) {
                quizImageView.image = quizImage
            } else {
                print("Image not found: \(quizImageName)")
            }
        } else {
            // クイズが終了した時にスコアを保存
            saveQuizScore(score: correctCount, date: Date(), time: Date())
            performSegue(withIdentifier: "toScoreVC", sender: nil)
            print("segue")
        }
    }
    
    // CSVファイルを読み込み、配列に格納する
    func loadCSV(fileName: String) -> [String] {
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do {
            let csvData = try String(contentsOfFile: csvBundle, encoding: String.Encoding.utf8)
            let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            csvArray = lineChange.components(separatedBy: "\n")
            csvArray.removeLast() // 最後の空行を削除
            
            // ランダムにシャッフル
            csvArray.shuffle()
            
            // 最初の10行だけを取得
            csvArray = Array(csvArray.prefix(10))
            print("CSV Array for \(fileName): \(csvArray)")
        } catch {
            print("エラー")
        }
        return csvArray
    }
    
    // クイズのスコアを保存する
    func saveQuizScore(score: Int, date: Date, time: Date) {
        let defaults = UserDefaults.standard
        var quizScores = defaults.array(forKey: "QuizScores") as? [[String: Any]] ?? []
        quizScores.append(["score": score, "date": date, "time": time])
        defaults.set(quizScores, forKey: "QuizScores")
    }
    
    // ユーザーのベストスコアを保存する
    func saveBestScore() {
        let defaults = UserDefaults.standard
        let savedBestScore = defaults.integer(forKey: "BestScore")
        if correctCount > savedBestScore {
            defaults.set(correctCount, forKey: "BestScore")
        }
    }
    
    // トップに戻るボタンのアクション
    @IBAction func reTopBuutonAction(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    // リセットメソッドを追加
       func resetBestScores() {
           let defaults = UserDefaults.standard
           defaults.set([], forKey: "QuizScores")
       }
}
