import UIKit

class FaqViewController: UIViewController {
    
    @IBOutlet weak var faqSearchBar: UISearchBar!
    @IBOutlet var categoryBtn: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.faqSearchBar.searchBarStyle = .minimal
        
    }
}

