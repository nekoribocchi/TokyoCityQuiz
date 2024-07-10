import UIKit
/ ランキング画面を表示するViewController
class RankViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var quizName: String = ""
    var bestScore = 0
    var topScores = [(score: Int, date: Date, time: Date)]()
    var correctCount = 0
    var scorePer_current: Int = 0
    var scorePer: Int = 0
    var bestScorePer: Int = 0
    let numberOfTopScoresToDisplay = 5
    var topScoresText = ""
    let quizCount = 10
    
    // ポートレートモードをサポート
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
    }
    
    // 画面を表示した時に呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        tableView.separatorColor = .systemPurple
        tableView.dataSource = self
        tableView.delegate = self
        
        // 保存されたクイズスコアを取得
        if let quizScores = UserDefaults.standard.array(forKey: "QuizScores") as? [[String: Any]] {
            for quiz in quizScores {
                if let score = quiz["score"] as? Int, let date = quiz["date"] as? Date, let time = quiz["time"] as? Date {
                    topScores.append((score: score, date: date, time: time))
                }
            }
        }
        
        // スコアを降順にソート
        topScores.sort { $0.score > $1.score }
        
        // トップ5スコアのみを保持
        topScores = Array(topScores.prefix(numberOfTopScoresToDisplay))
        
        // テーブルビューをリロード
        tableView.reloadData()
    }
    
    // UITableViewのセクション数を返す
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // UITableViewの行数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topScores.count
    }
    
    // UITableViewの各セルの高さを設定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    // 各セルに表示するデータを設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        
        let score = topScores[indexPath.row].score
        let date = topScores[indexPath.row].date
        let time = topScores[indexPath.row].time
        
        scorePer = Int(Double(score) / Double(quizCount) * 100)
        cell.scoreLabel.text = "\(indexPath.row + 1).  \(scorePer)点"
        
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        timeFormatter.dateFormat = "HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        let timeString = timeFormatter.string(from: time)
        cell.dateLabel.text = dateString
        cell.timeLabel.text = timeString
        return cell
    }
    
    // トップに戻るボタンのアクション
    @IBAction func reTopBuutonAction(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
