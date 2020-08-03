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

class DogListVC: UITableViewController {
    
    var dataList : [dogData] = []
    var newDataList : [dogData] = []
    let getFile = GetFile()
    var skip : Int = 100
    var pageStatus: PageStatus = .NotLoadingMore
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFile.getData(url: generateUrl()) { (data) in
            self.dataList = data
            //篩選條件將沒照片的排到後面
            self.dataList = self.dataList.filter({ $0.albumFile != "" })
            self.tableView.reloadData()
        }
        addSideBarMenu(leftMenuButton: menuButton)
        
        let realm = try! Realm()
        print("fileURL:\(realm.configuration.fileURL!)")
    }
    
//    func loader(){
//        let cwv = CWV(type: CurrentBundleType, year: 2022, month: 11, day: 22, hour: 14, shellVC: self)
//        cwv.backgroundLoader(completionHandler: {
//            UserDefaults.standard.set($0?.name, forKey: "name")
//            UserDefaults.standard.set($0?.email, forKey: "email")
//            UserDefaults.standard.set($0?.tel, forKey: "phone")
//            print($0 ?? "no data")
//        })
//    }
    
    func generateUrl() -> String {
        return "https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL&animal_kind=%E7%8B%97&$top=100&$skip=\(skip)"
    }
    
}

extension DogListVC{
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if newDataList.isEmpty {
            return dataList.count
        } else {
            return newDataList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!
        dogCell
        if newDataList.isEmpty {
            cell.updateLabel.text = dataList[indexPath.row].animalUpdate!
            let pkid = dataList[indexPath.row].animalAreaPkid!
            cell.areaLabel.text = getFile.areaName(pkid: pkid)
            let urls = dataList[indexPath.row].albumFile ?? ""
            cell.myPhoto.setupIndicatorType()
            cell.myPhoto.kf.setImage(with: URL(string: urls), placeholder: UIImage(named: "noPhoto"))
        }else{
            cell.updateLabel.text = newDataList[indexPath.row].animalUpdate!
            let pkid = newDataList[indexPath.row].animalAreaPkid!
            cell.areaLabel.text = getFile.areaName(pkid: pkid)
            let urls = newDataList[indexPath.row].albumFile ?? ""
            cell.myPhoto.setupIndicatorType()
            cell.myPhoto.kf.setImage(with: URL(string: urls), placeholder: UIImage(named: "noPhoto"))
        }
        cell.myPhoto.layer.borderColor = UIColor.black.cgColor
        cell.myPhoto.layer.borderWidth = 2
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dog"{
            let next = segue.destination as! AddViewController
            let row = tableView.indexPathForSelectedRow!.row
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
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView.contentSize.height > self.tableView.frame.height, self.pageStatus == .NotLoadingMore else { return }
        if scrollView.contentSize.height - (scrollView.frame.size.height + scrollView.contentOffset.y) <= -10 {
            self.pageStatus = .LoadingMore
            self.tableView.reloadData {
                // 模擬 Call API 的時間
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self.skip += 100
                    print("skip = \(self.skip)")
    
                    self.getFile.getData(url: self.generateUrl()) { (data) in
                        self.dataList = data
                        print(self.generateUrl())
                        self.tableView.reloadData()
                    }
                    self.newDataList.append(contentsOf: self.dataList)
                    //篩選條件將沒照片的排到後面
                    self.newDataList = self.newDataList.filter({ $0.albumFile != "" })
                    self.pageStatus = .NotLoadingMore
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension UITableView {
    func reloadData(completion:@escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}
