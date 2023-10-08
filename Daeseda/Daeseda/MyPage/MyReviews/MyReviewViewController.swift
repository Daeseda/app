import UIKit

class MyReviewViewController : UIViewController {
    
    let reviews: Int = 3
    
    let myReviewNicknames = [
        "권영주",
        "권영주",
        "권영주",
    ]
    
    let myReviewDates = [
        "2023-01-01",
        "2023-02-02",
        "2023-03-03"
    ]
    
    let myReviewImages = [
        "towel.jpg",
        "towel.jpg",
        "towel.jpg",
    ]
    
    let myReviewTexts = [
        "반가와요^^",
        "댓글 테스트",
        "안녕하세요!"
    ]
    
    let myReviewCategorys = [
        "생활빨래",
        "신발",
        "코트",
    ]
    
    let myReviewStarRatings = [
        "5",
        "4",
        "3",
    ]
    
    @IBOutlet weak var myReviewTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myReviewTableView.dataSource = self
        myReviewTableView.delegate = self
        
        myReviewTableView.rowHeight = UITableView.automaticDimension
        myReviewTableView.estimatedRowHeight = UITableView.automaticDimension
    }
}

extension MyReviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}

extension MyReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myReviewNicknames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myReviewsCell = tableView.dequeueReusableCell(withIdentifier: "myReviewsCell", for: indexPath) as! MyReviewTableViewCell
        
        myReviewsCell.myReviewDateLabel.text = myReviewDates[indexPath.row]
        
        // 이미지 파일 이름을 바로 사용
        let imageName = myReviewImages[indexPath.row]
        let image = UIImage(named: imageName)
        myReviewsCell.myReviewImage.image = image
        
        myReviewsCell.myReviewTextLabel.text = myReviewTexts[indexPath.row]
        
        // 버튼의 타이틀을 라벨 값으로 설정
        let selectedCategory = myReviewCategorys[indexPath.row]
        myReviewsCell.myReviewCategoryBtn.setTitle(selectedCategory, for: .normal)
        
        myReviewsCell.myReviewNicknameLabel.text = myReviewNicknames[indexPath.row]
        
        return myReviewsCell
    }
}
