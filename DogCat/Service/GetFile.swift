//
//  AlamofireGet.swift
//  DogCat
//
//  Created by user on 2020/6/1.
//  Copyright © 2020 abc. All rights reserved.
//

import Foundation
import Alamofire
import MapKit

class GetFile {
    //MARK:取網路api資料
    func getData(url:String, completion: @escaping([dogData]) ->Void){
        AF.request(url).responseJSON{response in
            if let data = response.data {
                do {
                    let dataList = try JSONDecoder().decode( [dogData].self, from: data)
                    completion(dataList)

                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    //MARK:CLGeocoder地理編碼 地址轉換經緯度位置
    func geocode(address: String, completion: @escaping (CLLocationCoordinate2D, Error?) -> ())  {
        CLGeocoder().geocodeAddressString(address) { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let placemarks = placemarks {
                //取得第一個地點標記
                let placemark = placemarks[0]
                //加上標記
                let annotation = MKPointAnnotation()
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    print("~~~\(annotation.coordinate)")
                    
                }
                completion(annotation.coordinate, nil)
            }
        }
    }
    
    func areaName(pkid:Int) -> String{
        switch pkid {
        case 2:
            return  "台北市"
        case 3:
            return  "新北市"
        case 4:
            return  "基隆市"
        case 5:
            return  "宜蘭縣"
        case 6:
            return  "桃園縣"
        case 7:
            return  "新竹縣"
        case 8:
            return  "新竹市"
        case 9:
            return  "苗栗縣"
        case 10:
            return  "臺中市"
        case 11:
            return "彰化縣"
        case 12:
            return  "南投縣"
        case 13:
            return  "雲林縣"
        case 14:
            return  "嘉義縣"
        case 15:
            return  "嘉義市"
        case 16:
            return  "臺南市"
        case 17:
            return  "高雄市"
        case 18:
            return  "屏東縣"
        case 19:
            return  "花蓮縣"
        case 20:
            return  "臺東縣"
        case 21:
            return  "澎湖縣"
        case 22:
            return  "金門縣"
        case 23:
            return  "連江縣"
        default:
            return ""
        }
    }
    
    func sexCh(sex:String) -> String {
        switch sex {
        case "M":
            return "男生"
        case "F":
            return "女生"
        case "N":
            return "未輸入"
        default:
            return ""
        }
    }
    
    func ageCh(age:String) -> String{
        switch age {
        case "CHILD":
            return "幼年"
        case "ADULT":
            return "成年"
        default:
            return "年齡不詳"
        }
    }
    
    func bodytypeCh(bodytype:String) -> String{
        switch bodytype {
        case "SMALL":
            return "小型"
        case "MEDIUM":
            return "中型"
        case "BIG":
            return "大型"
        default:
            return ""
        }
    }
    
    func sterilization(sterilization:String) -> String{
        switch sterilization {
        case "T":
            return "已絕育"
        case "F":
            return "未絕育"
        case "N":
            return "未確認"
        default:
            return ""
        }
    }
}
