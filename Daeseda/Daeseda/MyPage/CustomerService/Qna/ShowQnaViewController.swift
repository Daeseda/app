import UIKit

class ShowQnaViewController: UIViewController {
    
    let comentNicknames = [
        "피카츄",
        "도라에몽",
        "춘식이",
    ]
    
    let comentDates = [
        "2023-01-01",
        "2023-02-02",
        "2023-03-03"
    ]
    
    let comentTimes = [
        "00:12",
        "15:00",
        "20:25",
    ]
    
    let comentTexts = [
        "반가와요^^",
        "댓글 테스트",
        "안녕하세요!"
    ]
    
    @IBOutlet weak var comentTableView: UITableView!
    @IBOutlet weak var qnaTitle: UILabel!
    @IBOutlet weak var qnaDate: UILabel!
    @IBOutlet weak var qnaText: UILabel!
    @IBOutlet weak var qnaTime: UILabel!
    @IBOutlet weak var qnaNickname: UILabel!
    @IBOutlet weak var isPublic: UILabel!
    @IBOutlet weak var qnaComentCount: UILabel!
    
    var qnaTitleString: String?
    var qnaDateString: String?
    var qnaTextString: String?
    var qnaTimeString: String?
    var qnaNicknameString: String?
    var isPublicString: String?
    var qnaComentCountString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 이 곳에서 프로퍼티에 데이터를 할당하여 화면에 레이블에 표시할 수 있습니다.
        qnaTitle.text = qnaTitleString
        qnaDate.text = qnaDateString
        qnaText.text = qnaTextString
        qnaTime.text = qnaTimeString
        qnaNickname.text = qnaNicknameString
        isPublic.text = isPublicString
        qnaComentCount.text = "댓글 " + (qnaComentCountString ?? "0")

        comentTableView.dataSource = self
        comentTableView.delegate = self
        
        comentTableView.rowHeight = UITableView.automaticDimension
        comentTableView.estimatedRowHeight = UITableView.automaticDimension
    }


}

extension ShowQnaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 네비게이션 컨트롤러를 이용하여 뷰 컨트롤러를 푸시(push)합니다.
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


extension ShowQnaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comentTexts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comentCell = tableView.dequeueReusableCell(withIdentifier: "comentCell", for: indexPath) as! ComentTableViewCell
        
        comentCell.comentDateLabel.text = comentDates[indexPath.row]
        comentCell.comentTextLabel.text = comentTexts[indexPath.row]
        comentCell.comentNicknameLabel.text = comentNicknames[indexPath.row]
        comentCell.comentTimeLabel.text = comentTimes[indexPath.row]
        
        return comentCell
    }
}
