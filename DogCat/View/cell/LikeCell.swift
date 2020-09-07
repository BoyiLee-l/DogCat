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
        
        myPhoto.layer.borderColor = #colorLiteral(red: 0.02589932643, green: 0.02589932643, blue: 0.02589932643, alpha: 0.7178938356).cgColor
        myPhoto.layer.borderWidth = 2
        myPhoto.clipsToBounds = true
        myPhoto.layer.cornerRadius = 25
        
        updateLabel.backgroundColor = #colorLiteral(red: 0.1162804135, green: 0.8456138959, blue: 0.4789697292, alpha: 0.3300000131)
        updateLabel.clipsToBounds = true
        updateLabel.layer.cornerRadius = 15
        updateLabel.layer.borderColor = #colorLiteral(red: 0.02589932643, green: 0.02589932643, blue: 0.02589932643, alpha: 0.7178938356).cgColor
        updateLabel.layer.borderWidth = 2
        
        areaLabel.backgroundColor = #colorLiteral(red: 0.1162804135, green: 0.8456138959, blue: 0.4789697292, alpha: 0.3300000131)
        areaLabel.clipsToBounds = true
        areaLabel.layer.cornerRadius = 15
        areaLabel.layer.borderColor = #colorLiteral(red: 0.02589932643, green: 0.02589932643, blue: 0.02589932643, alpha: 0.7178938356).cgColor
        areaLabel.layer.borderWidth = 2
    }
    
}
