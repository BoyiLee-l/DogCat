//
//  MenuController.swift
//  DogDiary
//
//  Created by user on 2020/5/19.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

class MenuController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dog"{
            animals = .dog
            print(animals)
        }else{
            animals = .cat
            print(animals)
        }
    }
}
