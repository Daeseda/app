import UIKit

class QnaViewController: UIViewController {
    
    let titles = [
        "이거 왜 안돼요?",
        "처음 쓰는데 좋네요",
        "하하",
    ]
    
    let ninknames = [
        "김김김",
        "강강강",
        "고고고",
    ]
    
    let dates = [
        "2023-01-01",
        "2023-02-02",
        "2023-03-03"
    ]
    
    let times = [
        "00:12",
        "15:00",
        "20:25",
    ]
    
    let isPublics = [
        "공개",
        "비공개",
        "공개",
    ]
    
    let comentsCount = [
        "[2]",
        "[1]",
        "[0]",
    ]
    
    let texts = [
        "안녕하세요",
        "안녕하세요",
        "안녕하세요"
    ]
    
    @IBOutlet weak var qnaTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        qnaTableView.dataSource = self
        qnaTableView.delegate = self
        
        // 이 부분이 중요: 자동 높이 조절을 가능하게 설정
        qnaTableView.rowHeight = UITableView.automaticDimension
        qnaTableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
}

extension QnaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 네비게이션 컨트롤러를 이용하여 뷰 컨트롤러를 푸시(push)합니다.
        if let showQnaVC = self.storyboard?.instantiateViewController(withIdentifier: "ShowQna") as? ShowQnaViewController {
            
            showQnaVC.qnaTitleString = titles[indexPath.row]
            showQnaVC.qnaDateString = dates[indexPath.row]
            showQnaVC.qnaTextString = texts[indexPath.row]
            showQnaVC.qnaNicknameString = ninknames[indexPath.row]
            showQnaVC.qnaTimeString = times[indexPath.row]
            showQnaVC.isPublicString = isPublics[indexPath.row]
            showQnaVC.qnaComentCountString = comentsCount[indexPath.row]

            self.navigationController?.pushViewController(showQnaVC, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


extension QnaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let qnaCell = tableView.dequeueReusableCell(withIdentifier: "qnaCell", for: indexPath) as! QnaTableViewCell
        
        qnaCell.titleLabel.text = titles[indexPath.row]
        qnaCell.dateLabel.text = dates[indexPath.row]
        qnaCell.comentLabel.text = comentsCount[indexPath.row]
        qnaCell.nicknameLabel.text = ninknames[indexPath.row]
        qnaCell.timeLabel.text = times[indexPath.row]
        qnaCell.isPublicLabel.text = isPublics[indexPath.row]
        
        return qnaCell
    }
}
