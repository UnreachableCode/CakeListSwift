//
//  CakeCell.swift
//  cakelistswift
//
//  Created by Charlie Finlayson on 15/05/2019.
//  Copyright © 2019 Charlie Finlayson. All rights reserved.
//

import UIKit

class CakeCell: UITableViewCell {
    
    @IBOutlet weak var cakeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
