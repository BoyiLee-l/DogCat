//
//  SearchCell.swift
//  DogCat
//
//  Created by user on 2020/9/2.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        myLabel.font = UIFont(name: "Marker Felt", size: 26)
        myLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        contentLabel.font = UIFont(name: "Marker Felt", size: 22)
        contentLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        contentLabel.layer.borderWidth = 1.6
        contentLabel.layer.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        contentLabel.clipsToBounds = true
        contentLabel.layer.cornerRadius = 15
    }

}
