import UIKit

class MyAdressViewController: UIViewController {
    var selectedIndexPath: IndexPath?

    let homeTitle = "우리 집"
    let homeAdress = "서울시 노원구 초안산로 12"

    let otherAdressTitles = [
        "회사",
        "한강공원",
        "다른 주소 1",
    ]

    let otherAdressAdresses = [
        "서울시 노원구 초안산로 12 인관 301호",
        "서울 잠실 뭐시기",
        "다른 주소 1의 주소",
    ]

    @IBOutlet weak var myAdresSearchBar: UISearchBar!
    @IBOutlet weak var myAdressTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.myAdresSearchBar.searchBarStyle = .minimal
        self.title = "주소 설정"

        if let navigationBar = self.navigationController?.navigationBar {
            let font = WDFont.GmarketBold.of(size: 30)
            navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
        }

        let adressEditBarBtn = UIBarButtonItem(
            title: "편집",
            style: .plain,
            target: self,
            action: #selector(adressEditBarBtnTab)
        )

        navigationItem.rightBarButtonItem = adressEditBarBtn

        selectedIndexPath = IndexPath(row: 0, section: 0)
        
        myAdressTableView.delegate = self
        myAdressTableView.dataSource = self
    }

    @objc func adressEditBarBtnTab(_ sender: UIBarButtonItem) {
        guard let adressEditVC = storyboard?.instantiateViewController(withIdentifier: "AdressEdit") as? AdressEditViewController else { return }
        navigationController?.pushViewController(adressEditVC, animated: true)
    }
}

extension MyAdressViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == selectedIndexPath {
        } else {
            selectedIndexPath = indexPath
        }
        myAdressTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension MyAdressViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + otherAdressTitles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let myHomeCell = tableView.dequeueReusableCell(withIdentifier: "myHomeCell", for: indexPath) as! MyHomeTableViewCell

            myHomeCell.homeTitleLabel.text = homeTitle
            myHomeCell.homeAdressLabel.text = homeAdress

            let houseImage = UIImage(systemName: "house")
            let checkImage = UIImage(systemName: "checkmark.circle.fill")

            myHomeCell.homeImageView.image = houseImage
            myHomeCell.homeCheckImageView.isHidden = selectedIndexPath != indexPath
            myHomeCell.homeCheckImageView.image = checkImage

            return myHomeCell
        } else {
            let myAdressCell = tableView.dequeueReusableCell(withIdentifier: "myAdressCell", for: indexPath) as! MyAdressTableViewCell

            let otherAdressIndex = indexPath.row - 1
            myAdressCell.adressTitleLabel.text = otherAdressTitles[otherAdressIndex]
            myAdressCell.adressAdressLabel.text = otherAdressAdresses[otherAdressIndex]

            let adressImage = UIImage(systemName: "mappin.and.ellipse")
            let checkImage = UIImage(systemName: "checkmark.circle.fill")

            myAdressCell.adressImageView.image = adressImage
            myAdressCell.adressCheckImageView.isHidden = selectedIndexPath != indexPath
            myAdressCell.adressCheckImageView.image = checkImage

            return myAdressCell
        }
    }
}
