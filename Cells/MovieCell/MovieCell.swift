//
//  MovieCell.swift
//  Task
//
//  Created by A on 07/08/2023.
//

import UIKit
import SDWebImage

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(text: String, image: URL) {
        movieLabel.text = text
        movieImageView.sd_setImage(with: image)
    }
    
    
}
