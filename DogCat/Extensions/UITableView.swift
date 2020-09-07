//
//  UITableView.swift
//  DogCat
//
//  Created by user on 2020/9/1.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

extension UITableView {
    func reloadData(completion:@escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}
