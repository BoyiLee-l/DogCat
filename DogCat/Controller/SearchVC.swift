//
//  SearchVC.swift
//  DogCat
//
//  Created by user on 2020/9/2.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

struct SelectItem {
    var title: String
    var select: String
}

class SearchVC: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    let getFile = GetFile()
    weak var delegate: SearchVCDelegate?
    
    var dataList: [SelectItem] =
        [SelectItem(title: "城市", select: "") ,
         SelectItem(title: "性別", select: ""),
         SelectItem(title: "年紀", select: ""),
         SelectItem(title: "體型", select: ""),
         SelectItem(title: "已結紮", select: "")]
    var cityList = ["台北市","新北市","基隆市","宜蘭縣","桃園縣","新竹縣","新竹市","苗栗縣","臺中市","彰化縣","南投縣","雲林縣","嘉義縣","嘉義市","臺南市","高雄市","屏東縣","花蓮縣","臺東縣","澎湖縣","金門縣","連江縣"]
    var sexList = ["男生","女生"]
    var ageList = ["幼年","成年"]
    var bodytypeList = ["小型","中型","大型"]
    var sterilizationList = ["已絕育","未絕育"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "搜尋條件"
        myTableView.delegate = self
        myTableView.dataSource = self
        setBackground()
    }
    
    @IBAction func send(_ sender: Any) {
       self.navigationController?.popViewController(animated: true)
    }
    
    
    
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchCell
        
        let data = dataList[indexPath.row]
        
        cell.myLabel.text = data.title
        cell.contentLabel.text = data.select
      
        delegate?.doSomething(city: dataList[0].select, sex: dataList[1].select, age: dataList[2].select, body: dataList[3].select, sterilization: dataList[4].select)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            popupAlert(title: "選擇城市", message: nil, actionTitles: cityList) { city in
                //print(city)
                self.dataList[indexPath.row].select = city
                self.myTableView.reloadData()
            }
        case 1:
            popupAlert(title: "選擇性別", message: nil, actionTitles: sexList) { sex in
                //print(sex)
                self.dataList[indexPath.row].select = sex
                self.myTableView.reloadData()
            }
        case 2:
            popupAlert(title: "選擇年紀", message: nil, actionTitles: ageList) { age in
                //print(age)
                self.dataList[indexPath.row].select = age
                self.myTableView.reloadData()
            }
        case 3:
            popupAlert(title: "選擇體型", message: nil, actionTitles: bodytypeList) { body in
                //print(body)
                self.dataList[indexPath.row].select = body
                self.myTableView.reloadData()
            }
        case 4:
            popupAlert(title: "是否要絕育", message: nil, actionTitles: sterilizationList) { sterilization in
                //print(sterilization)
                self.dataList[indexPath.row].select = sterilization
                self.myTableView.reloadData()
            }
            
        default:
            print("")
            break

        }
    }

}

protocol SearchVCDelegate: class {
    func doSomething(city: String, sex: String, age: String, body: String, sterilization: String)
}
