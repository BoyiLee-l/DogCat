//
//  ringTableViewController.swift
//  DogDiary
//
//  Created by user on 2020/5/5.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class CatListVC: UITableViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var dataList = [dogData]()
    var newDataList : [dogData] = []
    let getFile = GetFile()
    var pageStatus: PageStatus = .NotLoadingMore
    var skip : Int = 100
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFile.getData(url: generateUrl()) { (data) in
            self.dataList = data
            //篩選條件將沒照片的排到後面
            self.dataList = self.dataList.filter({ $0.albumFile != "" })
            self.tableView.reloadData()
        }
        addSideBarMenu(leftMenuButton: menuButton)
    }
    
    func generateUrl() -> String {
        return "https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL&animal_kind=%E8%B2%93&$top=100&$skip=\(skip)"
    }
    
}
extension CatListVC{
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
        catCell
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
        if segue.identifier == "cat"{
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
extension UIImageView {
    func setupIndicatorType() {
        let path = Bundle.main.path(forResource: "loading", ofType: "gif")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        var kf = self.kf
        kf.indicatorType = .image(imageData: data)
    }
}
