//
//  diaryTableViewCell.swift
//  DogDiary
//
//  Created by user on 2020/5/4.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

class diaryCell: UITableViewCell {

    @IBOutlet weak var mylabel: UILabel!
    @IBOutlet weak var myimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
