import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController, MovieDetailView {
    
    
    var presenter: MovieDetailPresenter?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
    }
    func setupDetailView(title: String, overview: String, imageUrl: URL) {
        titleLabel.text = title
        overviewLabel.text = overview
        detailImageView.sd_setImage(with: imageUrl)
    }
}
