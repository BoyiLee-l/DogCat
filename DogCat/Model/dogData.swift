//
//  dogData.swift
//  DogCat
//
//  Created by user on 2020/5/29.
//  Copyright © 2020 abc. All rights reserved.

import Foundation

struct dogData : Codable {
    let albumFile : String?
    let albumUpdate : String?
    let animalAge : String?
    let animalAreaPkid : Int?
    let animalBacterin : String?
    let animalBodytype : String?
    let animalCaption : String?
    let animalCloseddate : String?
    let animalColour : String?
    let animalCreatetime : String?
    let animalFoundplace : String?
    let animalId : Int?
    let animalKind : String?
    let animalOpendate : String?
    let animalPlace : String?
    let animalRemark : String?
    let animalSex : String?
    let animalShelterPkid : Int?
    let animalStatus : String?
    let animalSterilization : String?
    let animalSubid : String?
    let animalTitle : String?
    let animalUpdate : String?
    let cDate : String?
    let shelterAddress : String?
    let shelterName : String?
    let shelterTel : String?
    
    
    enum CodingKeys: String, CodingKey {
        case albumFile = "album_file"
        case albumUpdate = "album_update"
        case animalAge = "animal_age"
        case animalAreaPkid = "animal_area_pkid"
        case animalBacterin = "animal_bacterin"
        case animalBodytype = "animal_bodytype"
        case animalCaption = "animal_caption"
        case animalCloseddate = "animal_closeddate"
        case animalColour = "animal_colour"
        case animalCreatetime = "animal_createtime"
        case animalFoundplace = "animal_foundplace"
        case animalId = "animal_id"
        case animalKind = "animal_kind"
        case animalOpendate = "animal_opendate"
        case animalPlace = "animal_place"
        case animalRemark = "animal_remark"
        case animalSex = "animal_sex"
        case animalShelterPkid = "animal_shelter_pkid"
        case animalStatus = "animal_status"
        case animalSterilization = "animal_sterilization"
        case animalSubid = "animal_subid"
        case animalTitle = "animal_title"
        case animalUpdate = "animal_update"
        case cDate = "cDate"
        case shelterAddress = "shelter_address"
        case shelterName = "shelter_name"
        case shelterTel = "shelter_tel"
    }
    
    
}
