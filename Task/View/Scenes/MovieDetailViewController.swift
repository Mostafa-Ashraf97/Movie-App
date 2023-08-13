//
//  MovieDetailViewController.swift
//  Task
//
//  Created by A on 09/08/2023.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupDetailView(title: String, year: String, overview: String, imageUrl: URL) {
        titleLabel.text = title
        yearLabel.text = year
        overviewLabel.text = overview
        
        detailImageView.sd_setImage(with: imageUrl)
    }
    
}
