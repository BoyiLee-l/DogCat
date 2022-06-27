//
//  addViewController.swift
//  DogDiary
//
//  Created by user on 2020/4/29.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
import RealmSwift
import MapKit
import RxCocoa

class DetailVC: UIViewController {
    
    enum DetailData {
        case 網路
        case 資料庫
    }
    
    var detailData: DetailData = .網路
    var animal: dogData?
    var likeCollection: Bool = false
    var likeData = [UserInfo]()
    let getFile = GetFile()
    var userInfo =  UserInfo()//給收藏頁面使用
    var cllocation = CLLocationCoordinate2D()
    
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var title3: UILabel!
    @IBOutlet weak var telBtn: UIButton!
    @IBOutlet weak var mapBtn: UIButton!
    @IBOutlet weak var myPhoto: UIImageView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var bodytypeLabel: UILabel!
    @IBOutlet weak var colourLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var sterilizationLabel: UILabel!
    @IBOutlet weak var shelterLabel: UILabel!
    @IBOutlet weak var likeBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        changeUI()
        read()
        viewVaule()
        getFile.geocode(address:animal?.shelterAddress ?? userInfo.shelterAddress) { (data, error) in
            self.cllocation = data
            print(self.cllocation)
        }
        
        if likeCollection == false{
            likeBtn.image = UIImage(named: "whiteheart")
        }else{
            likeBtn.image = UIImage(named: "heart")
        }
    }
    
    @IBAction func like(_ sender: UIButton) {
        switch detailData {
        case .網路:
            let allData: [UserInfo] = RealmManeger.shared.fetchAll()
            let myFavorite = allData.filter({ $0.animalId == animal?.animalId }).isEmpty
            if myFavorite {
                save()
                likeBtn.image = UIImage(named: "heart")
                alert(title: "已加入的我的收藏", completion: nil)
            } else {
                likeBtn.image = UIImage(named: "whiteheart")
                let deleteData = allData.filter({ $0.animalId == animal?.animalId }).first ?? UserInfo()
                RealmManeger.shared.delete(animal: deleteData)
                alert(title: "取消的我的收藏", completion: nil)
            }
        case .資料庫:
            likeBtn.image = UIImage(named: "whiteheart")
            RealmManeger.shared.delete(animal: userInfo)
           
            alert(title: "取消的我的收藏") { (_) in
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    @IBAction func share(_ sender: Any) {
        guard let image = self.myPhoto.image else { return }
        let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activity , animated: true)
    }
    
    @IBAction func callPhone(_ sender: Any) {
        guard let tel = animal?.shelterTel else {
            fatalError()
        }
        let controller = UIAlertController(title: "聯絡收容所", message: "\(tel)", preferredStyle: .actionSheet)
        let phoneAction = UIAlertAction(title: "打電話給\(tel)", style: .default) {(_) in
            if let url = URL(string: "tel:\(tel)"){
                if UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }else{
                    print("無法開啟url")
                }
            }else{
                print("連結錯誤")
            }
        }
        let canceAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(phoneAction)
        controller.addAction(canceAction)
        present(controller,animated: true, completion: nil)
    }
    
    @IBAction func mapSet(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        vc.cllocation = self.cllocation
        vc.titlename = (animal?.shelterName != nil ? animal?.shelterName : userInfo.animalPlace) ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func save(){
        guard let animal = animal else {
            fatalError()
        }
        RealmManeger.shared.add(animal: animal)        
    }
    
    func read(){
        likeData = RealmManeger.shared.fetchAll()
        print(likeData.count)
    }
    
    func alert(title: String, completion: ((UIAlertAction)-> Void)?) {
        let controller = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "確認", style: .default, handler: completion)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
}

extension DetailVC{
    
    func changeUI(){
        myPhoto.layer.borderColor = UIColor.black.cgColor
        myPhoto.layer.borderWidth = 2
        myPhoto.clipsToBounds = true
        myPhoto.layer.cornerRadius = 25
        
        title1.clipsToBounds = true
        title1.layer.cornerRadius = 15
        title2.clipsToBounds = true
        title2.layer.cornerRadius = 15
        title3.clipsToBounds = true
        title3.layer.cornerRadius = 15
        
        title1.layer.borderColor = UIColor.olive.cgColor
        title1.layer.borderWidth = 1.5
        title2.layer.borderColor = UIColor.olive.cgColor
        title2.layer.borderWidth = 1.5
        title3.layer.borderColor = UIColor.olive.cgColor
        title3.layer.borderWidth = 1.5
        
        placeLabel.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        placeLabel.layer.borderColor = UIColor.olive.cgColor
        placeLabel.layer.borderWidth = 1.5
        placeLabel.clipsToBounds = true
        placeLabel.layer.cornerRadius = 15
        
        shelterLabel.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        shelterLabel.layer.borderColor = UIColor.olive.cgColor
        shelterLabel.layer.borderWidth = 1.5
        shelterLabel.clipsToBounds = true
        shelterLabel.layer.cornerRadius = 15
        
        telBtn.clipsToBounds = true
        telBtn.layer.cornerRadius = 15
        telBtn.layer.borderColor = UIColor.olive.cgColor
        telBtn.layer.borderWidth = 1.5
        telBtn.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        mapBtn.layer.borderColor = UIColor.black.cgColor
        mapBtn.layer.borderWidth = 1.5
        mapBtn.clipsToBounds = true
        mapBtn.layer.cornerRadius = 15
    }
    
    func viewVaule(){
        switch detailData {
        case .資料庫:
            myPhoto.kf.setImage(with: URL(string: userInfo.albumFile) ,placeholder: UIImage(named: "noPhoto"))
            placeLabel.text = userInfo.animalPlace
            sexLabel.text = getFile.sexCh(sex: userInfo.animalSex )
            bodytypeLabel.text = getFile.bodytypeCh(bodytype: userInfo.animalBodytype )
            colourLabel.text = userInfo.animalColour
            ageLabel.text = getFile.ageCh(age: userInfo.animalAge )
            sterilizationLabel.text = getFile.sterilization(sterilization: userInfo.animalSterilization )
            shelterLabel.text = userInfo.shelterAddress
            likeCollection = true
        case .網路:
            myPhoto.kf.setImage(with: URL(string: animal?.albumFile ?? "") ,placeholder: UIImage(named: "noPhoto"))
            if animal?.animalFoundplace != ""{
                placeLabel.text = animal?.animalFoundplace
            }else{
                placeLabel.text = "查無尋獲地"
            }
            sexLabel.text = getFile.sexCh(sex: animal?.animalSex ?? "")
            bodytypeLabel.text = getFile.bodytypeCh(bodytype: animal?.animalBodytype ?? "")
            colourLabel.text = animal?.animalColour
            ageLabel.text = getFile.ageCh(age: animal?.animalAge ?? "")
            sterilizationLabel.text = getFile.sterilization(sterilization: animal?.animalSterilization ?? "")
            shelterLabel.text = animal?.shelterAddress
            
            likeCollection = likeData.filter({ (userInfo) -> Bool in
                userInfo.animalId == animal?.animalId
            }).isEmpty ? false: true
        }
        
        print(likeCollection)
    }
    
    
}
