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
    
    var pageStatus: PageStatus = .NotLoadingMore
    
    let caseEN = CaseEN()
    
    var viewModel = PetListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        setUI()
        setupActivityView()
        addSideBarMenu(leftMenuButton: menuButton)
        viewModel.getPetList()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.myTableView.reloadData()
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
        if viewModel.newDataList.isEmpty {
            return viewModel.dataList.count
        } else {
            return viewModel.newDataList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!
        petCell
        
        if viewModel.dataList.isEmpty{
            let alertController = UIAlertController(title: "沒有資料唷", message: "請重新再搜尋一次", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else if viewModel.newDataList.isEmpty {
            let data = viewModel.dataList[indexPath.row]
            cell.updateLabel.text = data.animalUpdate
            let pkid = data.animalAreaPkid
            cell.areaLabel.text = viewModel.getFile.areaName(pkid: pkid ?? 0)
            let urls = data.albumFile ?? ""
            cell.myPhoto.setupIndicatorType()
            cell.myPhoto.kf.setImage(with: URL(string: urls), placeholder: UIImage(named: "noPhoto"))
        }else{
            let data = viewModel.newDataList[indexPath.row]
            cell.updateLabel.text = data.animalUpdate
            let pkid = data.animalAreaPkid
            cell.areaLabel.text = viewModel.getFile.areaName(pkid: pkid ?? 0)
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
            if viewModel.newDataList.isEmpty{
                let data = viewModel.dataList[row]
                next.animal = data
            }else{
                let data = viewModel.newDataList[row]
                next.animal = data
            }
        }
    }
    
    //向下滑動觸發在load
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView.contentSize.height > self.myTableView.frame.height, self.pageStatus == .NotLoadingMore else { return }
        if scrollView.contentSize.height - (scrollView.frame.size.height + scrollView.contentOffset.y) <= -10 {
            self.pageStatus = .LoadingMore
            
            // 模擬 Call API 的時間
            DispatchQueue.main.asyncAfter(deadline: .now()) { [self] in
                viewModel.skip += 100
                print("skip = \(viewModel.skip)")
                print("apiurl:\(viewModel.generateUrl())")
                viewModel.getPetList()
                viewModel.newDataList.append(contentsOf: viewModel.dataList)
                //篩選條件將沒照片的排到後面
                viewModel.newDataList = viewModel.newDataList.filter({ $0.albumFile != "" })
                self.pageStatus = .NotLoadingMore
                
                viewModel.reloadTableView = { [weak self] in
                    DispatchQueue.main.async {
                        self?.myTableView.reloadData()
                    }
                }
            }
        }
    }
}

extension PetListVC: SearchVCDelegate{
    
    func doSomething(city: String, sex: String, age: String, body: String, sterilization: String) {
        viewModel.city = city
        viewModel.sex = sex
        viewModel.age = age
        viewModel.bodytype = body
        viewModel.sterilization = sterilization
        
        //MARK:將字串轉換參數型態
        viewModel.pkid = caseEN.areaName(pkid: viewModel.city)
        viewModel.sex = caseEN.sexCh(sex: viewModel.sex)
        viewModel.age = caseEN.ageCh(age: viewModel.age)
        viewModel.bodytype = caseEN.bodytypeCh(bodytype: viewModel.bodytype)
        viewModel.sterilization = caseEN.sterilization(sterilization: viewModel.sterilization)
        
        print(viewModel.pkid, viewModel.sex, viewModel.age, viewModel.bodytype, viewModel.sterilization)
        
        //MARK:判斷如果下新的條件,將原有陣列清空
        if viewModel.pkid != 0 || viewModel.sex != "" || viewModel.age != "" || viewModel.bodytype != "" || viewModel.sterilization != ""{
            viewModel.newDataList.removeAll()
        }
        viewModel.getPetList()
    }
    
}
