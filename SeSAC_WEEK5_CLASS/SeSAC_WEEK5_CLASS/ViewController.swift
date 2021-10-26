//
//  ViewController.swift
//  SeSAC_WEEK5_CLASS
//
//  Created by 노건호 on 2021/10/25.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrentWeather()
    }
    
    func getCurrentWeather() {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=37.547750&lon=126.942186&appid=477e2dd8bde558dc3a2f9af8702b194a"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                print("JSON: \(json)")
                print(json["main"]["temp"])
                
                let currentTemp = json["main"]["temp"].doubleValue - 273.15
                self.currentTempLabel.text = "\(Int(currentTemp))°C"
                
                let currentWindSpeed = json["wind"]["speed"].doubleValue
                self.windSpeedLabel.text = String(currentWindSpeed) + "바람"
                
                let currentHumidity = json["main"]["humidity"].intValue
                self.humidityLabel.text = String(currentHumidity) + "습도"
                
            case .failure(let error):
                
                print(error)
            }
        }
    }


}

