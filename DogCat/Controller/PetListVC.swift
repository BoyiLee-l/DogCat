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
import RxSwift
import RxCocoa

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
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        initialization()
        setupActivityView()
        addSideBarMenu(leftMenuButton: menuButton)
        viewModel.getPetList()
        bindTable()
    }
    
    func initialization() {
        switch animals {
        case .dog:
            self.navigationItem.title = "小狗列表"
        case .cat:
            self.navigationItem.title = "小貓列表"
        }
    }
    
    func bindTable() {
        myTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
            viewModel.dataList
                .bind(to: myTableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as!
                petCell
            
                cell.updateLabel.text = element.animalUpdate
                let pkid = element.animalAreaPkid
                cell.areaLabel.text = self.viewModel.getFile.areaName(pkid: pkid ?? 0)
                let urls = element.albumFile ?? ""
                cell.myPhoto.setupIndicatorType()
                cell.myPhoto.kf.setImage(with: URL(string: urls), placeholder: UIImage(named: "noPhoto"))
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    @IBAction func showSearch(_ sender: Any) {
        if let next = storyboard?.instantiateViewController(withIdentifier: "SearchVC") as? SearchVC {
            next.delegate = self
            show(next, sender: nil)
        }
    }
    
}

extension PetListVC: UITableViewDelegate{
    
    // MARK: - Table view data source
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailed"{
            let next = segue.destination as! DetailVC
            let row = myTableView.indexPathForSelectedRow!.row
            let data = viewModel.dataList.value[row]
            next.animal = data
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
                viewModel.getPetList()
                self.pageStatus = .NotLoadingMore
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
        viewModel.getPetList()
    }
    
}
