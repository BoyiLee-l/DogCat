//
//  UIViewController.swift
//  DogCat
//
//  Created by user on 2020/9/1.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
import SCLAlertView

var spinner: UIActivityIndicatorView = {
    let activityView = UIActivityIndicatorView()
    activityView.style = .gray
    return activityView
}()

extension UIViewController {
    //MARK:背景顏色設定
    func setBackground(){
        let colour1 = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 0.3063195634).cgColor
        let colour2 = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        //let colour3 = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [colour1,colour2]
        gradient.locations = [ 0.8,1.0]
        view.layer.insertSublayer(gradient, at: 0)
        
    }
    
    //MARK:-ActivityView方法
    func setupActivityView(){
        view.addSubview(spinner)
        spinner.center = view.center
    }
    
    func startLoading(){
        spinner.startAnimating()
        spinner.isHidden = false
    }
    
    func stopLoading(){
        spinner.stopAnimating()
        spinner.isHidden = true
    }
    //MARK:alert 設定
    func popupAlert(title: String?, message: String?, actionTitles: [String],  completion: @escaping (String) -> Void){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for actionTitle in actionTitles {
            let action = UIAlertAction(title: actionTitle, style: .default, handler: { _ in
                completion(actionTitle)
            })
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel){ (_) in
            completion("")
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
}
