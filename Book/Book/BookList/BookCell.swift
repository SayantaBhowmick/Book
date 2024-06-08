//
//  BookCell.swift
//  Book
//
//  Created by Hanriver Macbook on 08/06/24.
//

import UIKit
import Kingfisher

class BookCell: UITableViewCell {

    @IBOutlet weak var imageViewBook: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var datasource: Book? {
        didSet {
            // Ensure outlets are connected before updating the UI
            guard let item = datasource else {return}
            if let url = item.download_url {
                let url = URL(string: url)
                imageViewBook.kf.indicatorType = .activity
                imageViewBook.kf.setImage(with: url)
            }

            labelTitle.text = "Author: " + (item.author ?? "")
            labelDescription.text = "Details: " + (item.url ?? "")
        }
    }

}
