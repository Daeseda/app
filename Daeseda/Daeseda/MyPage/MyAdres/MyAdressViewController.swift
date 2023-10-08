import UIKit

class MyAdressViewController: UIViewController {
    
    @IBOutlet weak var myAdresSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myAdresSearchBar.searchBarStyle = .minimal

    }
    
}
