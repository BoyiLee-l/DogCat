//
//  LikeListViewModel.swift
//  DogCat
//
//  Created by DuncanLi on 2022/6/27.
//  Copyright © 2022 abc. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift

class LikeListViewModel {
    
    var likeData = BehaviorRelay <[UserInfo]>(value:[])
    
    func getRealmData(){
        let data = RealmManeger.shared.fetchAll()
        likeData.accept(data)
        print(likeData.value)
    }
}
