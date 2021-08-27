//
//  Dog.swift
//  DogDiary
//
//  Created by user on 2020/4/30.
//  Copyright © 2020 abc. All rights reserved.
//

import Foundation
import RealmSwift

class UserInfo: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var animalId: Int = 0
    @objc dynamic var animalUpdate: String = ""
    @objc dynamic var animalAreaPkid: Int = 0
    @objc dynamic var albumFile: String = ""
    @objc dynamic var animalPlace: String = ""
    @objc dynamic var animalSex: String = ""
    @objc dynamic var animalBodytype: String = ""
    @objc dynamic var animalColour: String = ""
    @objc dynamic var animalAge: String = ""
    @objc dynamic var animalFoundplace: String = ""
    @objc dynamic var animalSterilization: String = ""
    @objc dynamic var shelterAddress: String = ""
    @objc dynamic var shelterTel: String = ""
    @objc dynamic var collection: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
}
class RealmManeger {
    
    let realm = try! Realm()
    static let shared = RealmManeger()
    
    func delete(animal: UserInfo) {
        try! realm.write {
            realm.delete(animal)
        }
    }
    
    func add(animal: dogData) {
        
        let userInfo = UserInfo()
        
        userInfo.animalId = animal.animalId ?? 0
        userInfo.albumFile = animal.albumFile ?? ""
        userInfo.animalUpdate = animal.animalUpdate ?? ""
        userInfo.animalAge = animal.animalAge ?? ""
        userInfo.animalAreaPkid = animal.animalAreaPkid ?? 0
        userInfo.animalBodytype = animal.animalBodytype ?? ""
        userInfo.animalColour = animal.animalColour ?? ""
        userInfo.animalPlace = animal.animalPlace ?? ""
        userInfo.animalSex = animal.animalSex ?? ""
        userInfo.animalFoundplace = animal.animalFoundplace ?? ""
        userInfo.animalSterilization = animal.animalSterilization ?? ""
        userInfo.shelterAddress = animal.shelterAddress ?? ""
        userInfo.shelterTel = animal.shelterTel ?? ""
        userInfo.collection = true
        
        try! realm.write {
            realm.add(userInfo)
        }
    }
    
    func fetchAll() -> [UserInfo] {
        var allData = [UserInfo]()
        let datas = realm.objects(UserInfo.self)
        for data in datas{
            allData.append(data)
        }
        return allData
    }
    
}
