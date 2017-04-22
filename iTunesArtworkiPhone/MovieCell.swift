//
//  MovieCell.swift
//  iTunesArtworkiPhone
//
//  Created by piyo on 2017/04/19.
//  Copyright © 2017年 piyo. All rights reserved.
//

import Foundation
import UIKit

internal final class MovieCell: UITableViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var trackTitle: UILabel!
    
    var itemUrl: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        itemImageView.image = nil
    }
    
}
