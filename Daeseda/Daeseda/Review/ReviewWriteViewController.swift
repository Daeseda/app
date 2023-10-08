import UIKit

class ReviewWriteViewController: UIViewController {
    
    let allCategorys = [
        "전체",
        "생활빨래",
        "가방",
        "신발",
        "코트",
        "대형이불",
        "등등등1",
        "등등등2",
        "등등등3",
    ]
    
    @IBOutlet var reviewStarRatingBtns: [UIButton]!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var reviewWriteCategoryBtn: UIButton!
    
    @IBOutlet weak var reviewWriteCategoryPickerView: UIPickerView!
    var rating: Int = 1 // 최소 별점을 1로 설정
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reviewTextView.layer.borderWidth = 1.0
        self.reviewTextView.layer.borderColor = UIColor.black.cgColor
        
        // 별점 버튼에 액션 추가
        for (index, button) in reviewStarRatingBtns.enumerated() {
            button.tag = index
            button.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
        }
        
        // 초기 별점 UI 업데이트
        updateStarUI()
        
        reviewWriteCategoryPickerView.delegate = self
        reviewWriteCategoryPickerView.dataSource = self
        reviewWriteCategoryPickerView.isHidden = true
        
        self.title = "리뷰 작성"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 탭 바를 숨깁니다.
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 다른 화면으로 이동할 때 탭 바를 다시 보이게 합니다.
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc func starButtonTapped(_ sender: UIButton) {
        // 별점 버튼을 터치했을 때 호출되는 메서드
        if sender.tag == rating - 1 {
            // 이미 선택된 별점 버튼을 다시 선택하면 별점을 0으로 설정
            rating = 0
        } else {
            rating = sender.tag + 1
        }
        updateStarUI()
    }
    
    func updateStarUI() {
        // 별점 선택을 표시하기 위한 UI 업데이트
        for (index, button) in reviewStarRatingBtns.enumerated() {
            if index < rating {
                button.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                button.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
    }
    
    
    @IBAction func reviewWriteCategoryBtn(_ sender: UIButton) {
        showWriteCategoryPicker()
    }
    
    func showWriteCategoryPicker() {
        reviewWriteCategoryPickerView.isHidden = false
    }
}

extension ReviewWriteViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return allCategorys[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCategory = allCategorys[row]
        reviewWriteCategoryBtn.setTitle(selectedCategory, for: .normal)
        reviewWriteCategoryPickerView.isHidden = true
    }
}


extension ReviewWriteViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allCategorys.count
    }
    
    
}
