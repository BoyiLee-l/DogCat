//
//  ViewController.swift
//  DogDiary
//
//  Created by user on 2020/4/29.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher
import RxCocoa
import RxSwift

class LikeListVC: UIViewController{
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var myTableView: UITableView!
    
    let getFile = GetFile()
    
    var viewModel = LikeListViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        addSideBarMenu(leftMenuButton: menuButton)
        setUI()
        bindTable()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getRealmData()
    }
    
    func setUI(){
        navigationItem.title = "我的收藏"
    }
    
    func bindTable() {
        myTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.likeData
            .bind(to: myTableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as!
                LikeCell
                
                let urls = element.albumFile
                cell.myPhoto.kf.setImage(with: URL(string: urls), placeholder: UIImage(named: "noPhoto"))
                cell.updateLabel.text = element.animalUpdate
                let pkid = element.animalAreaPkid
                cell.areaLabel.text = self.getFile.areaName(pkid: pkid)
                print(element.collection)
                
                return cell
            }
            .disposed(by: disposeBag)
    }
}

extension LikeListVC: UITableViewDelegate{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "like"{
            let next = segue.destination as! DetailVC
            let row = myTableView.indexPathForSelectedRow!.row
            let data = viewModel.likeData.value[row]
            next.userInfo = data
            next.detailData = .資料庫
            print(next.userInfo)
            
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let row = myTableView.indexPathForSelectedRow!.row
            let data = viewModel.likeData.value[row]
            RealmManeger.shared.delete(animal: data)
        }
        
    }
    
}
