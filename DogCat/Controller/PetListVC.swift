//
//  dataTableViewController.swift
//  DogDiary
//
//  Created by user on 2020/4/30.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import RealmSwift


/// 頁面狀態
enum PageStatus {
    case LoadingMore
    case NotLoadingMore
}

enum Animals{
    case dog
    case cat
}
var animals: Animals = .dog


class PetListVC: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var myTableView: UITableView!
    
    
    var dataList : [dogData] = []
    var newDataList : [dogData] = []
    let getFile = GetFile()
    var pageStatus: PageStatus = .NotLoadingMore
    let caseEN = CaseEN()
    
    //MARK:api使用參數
    var skip : Int = 100
    var sex = ""
    var city = ""
    var pkid: Int = 0
    var age = ""
    var sterilization = ""
    var bodytype = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("apiurl:\(generateUrl())")
        setBackground()
        setUI()
        setupActivityView()
        requestData()
        addSideBarMenu(leftMenuButton: menuButton)
        //let realm = try! Realm()
        //print("fileURL:\(realm.configuration.fileURL!)")
    }
    
    //MARK:-跟網路求去資料
    func requestData(){
        self.myTableView.isHidden = false
        startLoading()
        getFile.getData(url: generateUrl()) { (data) in
            self.dataList = data
            //篩選條件將沒照片的排到後面
            self.dataList = self.dataList.filter({ $0.albumFile != "" })
            if self.dataList.isEmpty{
               
            }else{
                self.stopLoading()
                self.myTableView.reloadData()
            }
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
    
    func setUI(){
        myTableView.delegate = self
        myTableView.dataSource = self
        
        switch animals {
        case .dog:
            self.navigationItem.title = "小狗列表"
        case .cat:
            self.navigationItem.title = "小貓列表"
        }
    }
    
    @IBAction func showSearch(_ sender: Any) {
        if let next = storyboard?.instantiateViewController(withIdentifier: "SearchVC") as? SearchVC {
            next.delegate = self
            show(next, sender: nil)
        }
    }
    
}

extension PetListVC: UITableViewDelegate, UITableViewDataSource{
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if newDataList.isEmpty {
            return dataList.count
        } else {
            return newDataList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!
        petCell
        
        if dataList.isEmpty{
            let alertController = UIAlertController(title: "沒有資料唷", message: "請重新再搜尋一次", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if newDataList.isEmpty {
            let data = dataList[indexPath.row]
            cell.updateLabel.text = data.animalUpdate
            let pkid = data.animalAreaPkid
            cell.areaLabel.text = getFile.areaName(pkid: pkid ?? 0)
            let urls = data.albumFile ?? ""
            cell.myPhoto.setupIndicatorType()
            cell.myPhoto.kf.setImage(with: URL(string: urls), placeholder: UIImage(named: "noPhoto"))
        }else{
            let data = newDataList[indexPath.row]
            cell.updateLabel.text = data.animalUpdate
            let pkid = data.animalAreaPkid
            cell.areaLabel.text = getFile.areaName(pkid: pkid ?? 0)
            let urls = data.albumFile ?? ""
            cell.myPhoto.setupIndicatorType()
            cell.myPhoto.kf.setImage(with: URL(string: urls), placeholder: UIImage(named: "noPhoto"))
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailed"{
            let next = segue.destination as! DetailVC
            let row = myTableView.indexPathForSelectedRow!.row
            if newDataList.isEmpty{
                let data = dataList[row]
                next.animal = data
            }else{
                let data = newDataList[row]
                next.animal = data
            }
        }
    }
    //向下滑動觸發在load
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView.contentSize.height > self.myTableView.frame.height, self.pageStatus == .NotLoadingMore else { return }
        if scrollView.contentSize.height - (scrollView.frame.size.height + scrollView.contentOffset.y) <= -10 {
            self.pageStatus = .LoadingMore
            self.myTableView.reloadData {
                // 模擬 Call API 的時間
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self.skip += 100
                    print("skip = \(self.skip)")
                    print("apiurl:\(self.generateUrl())")
                    self.requestData()
                    self.newDataList.append(contentsOf: self.dataList)
                    //篩選條件將沒照片的排到後面
                    self.newDataList = self.newDataList.filter({ $0.albumFile != "" })
                    self.pageStatus = .NotLoadingMore
                    self.myTableView.reloadData()
                }
            }
        }
    }
}

extension PetListVC: SearchVCDelegate{
    
    func doSomething(city: String, sex: String, age: String, body: String, sterilization: String) {
        self.city = city
        self.sex = sex
        self.age = age
        self.bodytype = body
        self.sterilization = sterilization
        
        //MARK:將字串轉換參數型態
        self.pkid = caseEN.areaName(pkid: self.city)
        self.sex = caseEN.sexCh(sex: self.sex)
        self.age = caseEN.ageCh(age: self.age)
        self.bodytype = caseEN.bodytypeCh(bodytype: self.bodytype)
        self.sterilization = caseEN.sterilization(sterilization: self.sterilization)
        
        print(self.pkid, self.sex, self.age, self.bodytype, self.sterilization)
        //print("apiurl:\(generateUrl())")
        
        //MARK:判斷如果下新的條件,將原有陣列清空
        if self.pkid != 0 || self.sex != "" || self.age != "" || self.bodytype != "" || self.sterilization != ""{
            newDataList.removeAll()
        }
        
        requestData()
    }
    
    
}
