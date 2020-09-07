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

class LikeListVC: UIViewController{
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var myTableView: UITableView!
    var likeData = [UserInfo]()
    let getFile = GetFile()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        setBackground()
        addSideBarMenu(leftMenuButton: menuButton)
        setUI()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        setData()
        print(likeData.count)
    }
    
    func setData(){
        likeData = RealmManeger.shared.fetchAll() 
        myTableView.reloadData()
    }
}

extension LikeListVC{
    func setUI(){
        navigationItem.title = "我的收藏"
    }
}

extension LikeListVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LikeCell
        
        let urls = likeData[indexPath.row].albumFile
        cell.myPhoto.kf.setImage(with: URL(string: urls), placeholder: UIImage(named: "noPhoto"))
        cell.updateLabel.text = likeData[indexPath.row].animalUpdate
        let pkid = likeData[indexPath.row].animalAreaPkid
        cell.areaLabel.text = getFile.areaName(pkid: pkid)
        print(likeData[indexPath.row].collection)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "like"{
            let next = segue.destination as! DetailVC
            let row = myTableView.indexPathForSelectedRow!.row
            let data = likeData[row]
            next.userInfo = data
            next.detailData = .資料庫
            print(next.userInfo)
            
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let data = likeData[indexPath.row]
            RealmManeger.shared.delete(animal: data)
            likeData.remove(at: indexPath.row)
            myTableView.reloadData()
        }
        
    }
    
}
