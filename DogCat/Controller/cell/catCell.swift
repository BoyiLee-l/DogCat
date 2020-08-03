//
//  ringTableViewCell.swift
//  DogDiary
//
//  Created by user on 2020/5/5.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class catCell: UITableViewCell {
    
    @IBOutlet weak var myPhoto: UIImageView!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var updateLabel: UILabel!
    @IBOutlet weak var acitivityView: NVActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
