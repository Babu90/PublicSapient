//
//  PlayItemCell.swift
//  LastFM
//
//  Created by Babu on 19/03/2021.
//

import UIKit

class PlayItemCell: UITableViewCell {

    @IBOutlet weak var imgView:UIImageView!
    @IBOutlet weak var title:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgView?.layer.borderColor = UIColor.systemGray.cgColor
        self.imgView?.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.systemGray.cgColor
        self.contentView.layer.borderWidth = 1.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
