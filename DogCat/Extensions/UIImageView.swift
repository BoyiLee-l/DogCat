//
//  UIImageView.swift
//  DogCat
//
//  Created by user on 2020/9/1.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

//MARK:kingfisher 套件IndicatorType客製化圖案
extension UIImageView {
    func setupIndicatorType() {
        let path = Bundle.main.path(forResource: "gif5", ofType: "gif")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        var kf = self.kf
        kf.indicatorType = .image(imageData: data)
    }
}
