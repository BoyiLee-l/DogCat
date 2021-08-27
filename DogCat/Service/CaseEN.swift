//
//  caseEN.swift
//  DogCat
//
//  Created by user on 2020/9/7.
//  Copyright © 2020 abc. All rights reserved.
//

import Foundation

class CaseEN {
    
    func areaName(pkid: String) -> Int{
        switch pkid {
        case "台北市":
            return 2
        case "新北市":
            return 3
        case "基隆市":
            return 4
        case "宜蘭縣":
            return 5
        case "桃園縣":
            return 6
        case "新竹縣":
            return 7
        case "新竹市":
            return 8
        case "苗栗縣":
            return 9
        case "臺中市":
            return 10
        case "彰化縣":
            return 11
        case "南投縣":
            return 12
        case "雲林縣":
            return 13
        case "嘉義縣":
            return 14
        case "嘉義市":
            return 15
        case "臺南市":
            return 16
        case "高雄市":
            return 17
        case "屏東縣":
            return 18
        case "花蓮縣":
            return 19
        case "臺東縣":
            return 20
        case "澎湖縣":
            return 21
        case  "金門縣":
            return 22
        case "連江縣":
            return 23
        default:
            return 0
        }
    }
    
    func sexCh(sex:String) -> String {
        switch sex {
        case "男生":
            return "M"
        case "女生":
            return "F"
        case "未輸入":
            return "N"
        default:
            return ""
        }
    }
    
    func ageCh(age:String) -> String{
        switch age {
        case "幼年":
            return "CHILD"
        case "成年":
            return "ADULT"
        default:
            return ""
        }
    }
    
    func bodytypeCh(bodytype:String) -> String{
        switch bodytype {
        case "小型":
            return "SMALL"
        case "中型":
            return "MEDIUM"
        case "大型":
            return "BIG"
        default:
            return ""
        }
    }
    
    func sterilization(sterilization:String) -> String{
        switch sterilization {
        case "已絕育":
            return "T"
        case "未絕育":
            return "F"
        case "未確認":
            return "N"
        default:
            return ""
        }
    }
}
