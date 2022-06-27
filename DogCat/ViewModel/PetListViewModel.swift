//
//  PetListViewModel.swift
//  DogCat
//
//  Created by DuncanLi on 2022/6/24.
//  Copyright © 2022 abc. All rights reserved.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift

class PetListViewModel {
   
    var dataList = BehaviorRelay <[dogData]>(value:[])
    
    let getFile = GetFile()
    
    var pageStatus: PageStatus = .NotLoadingMore
    
    var reloadTableView: (() -> Void)?
    
    //MARK:api使用參數
    var skip : Int = 100
    var sex = ""
    var city = ""
    var pkid: Int = 0
    var age = ""
    var sterilization = ""
    var bodytype = ""
    
    let disposeBag = DisposeBag()
    
    //MARK:-跟網路求去資料
    func getPetList(){
        getFile.getData(url: generateUrl()) { (data) in
            let  filterData = data.filter { $0.albumFile != ""}
            self.dataList.accept(filterData)
//            print(self.dataList.value)
//            self.reloadTableView?()
        }
    }
    
    func generateUrl() -> String {
        switch animals {
        case .dog:
            if pkid == 0{
                return "https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL&animal_kind=%E7%8B%97&$top=100&$skip=\(skip)&animal_sex=\(sex)&animal_bodytype=\(bodytype)&animal_age=\(age)&animal_sterilization=\(sterilization)"
            }else{
                return "https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL&animal_kind=%E7%8B%97&$top=100&$skip=\(skip)&animal_sex=\(sex)&animal_area_pkid=\(pkid)&animal_bodytype=\(bodytype)&animal_age=\(age)&animal_sterilization=\(sterilization)"
            }
        case .cat:
            if pkid == 0{
                return "https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL&animal_kind=%E8%B2%93&$top=100&$skip=\(skip)&animal_sex=\(sex)&animal_bodytype=\(bodytype)&animal_age=\(age)&animal_sterilization=\(sterilization)"
            }else{
                return "https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL&animal_kind=%E8%B2%93&$top=100&$skip=\(skip)&animal_sex=\(sex)&animal_area_pkid=\(pkid)&animal_bodytype=\(bodytype)&animal_age=\(age)&animal_sterilization=\(sterilization)"
            }
        }
    }
}
