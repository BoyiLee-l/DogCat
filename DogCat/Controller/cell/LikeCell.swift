//
//  LikeCell.swift
//  DogCat
//
//  Created by user on 2020/7/28.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

class LikeCell: UITableViewCell {
    
    @IBOutlet weak var myPhoto: UIImageView!
    @IBOutlet weak var updateLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
