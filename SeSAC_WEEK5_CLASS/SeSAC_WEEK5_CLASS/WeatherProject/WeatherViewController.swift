//
//  WeatherViewController.swift
//  SeSAC_WEEK5_CLASS
//
//  Created by 노건호 on 2021/10/25.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController {
    
    static let identifier = "WeatherViewController"
    
    // Key값은 gitignore로 가려줌
    let key = Key.weatherKey
    
    // 온도 담아놓는 변수
    var temperature: Int = 0 {
        didSet {
            setTemperatureLabel(self.temperature)
        }
    }
    
    // 습도 담아두는 버튼
    var humidity: Int = 0 {
        didSet {
            setHumidityLabel(self.humidity)
        }
    }
    
    // 풍속 변수
    var wind: Int = 0 {
        didSet {
            setWindLabel(self.wind)
        }
    }
    
    var imageLink: String = "" {
        didSet {
            setWeatherImageView(self.imageLink)
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var windArrowImageView: UIImageView!
    @IBOutlet weak var currentPosition: UILabel!
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var goodDayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        // 오늘날짜 설정
        setDateLabel()
        
        // 라벨환경변수 설정(모두다 같아서 하나로 묶어줌)
        setBasicEnvironmentLabel(temperatureLabel)
        setBasicEnvironmentLabel(humidityLabel)
        setBasicEnvironmentLabel(windLabel)
        setBasicEnvironmentLabel(goodDayLabel)
        
        // 이미지뷰 환경설정
        setImageView(weatherImageView)
        
        // 좋은하루 되세요 설정
        setGoodDayLabel()
        
        // 아래 라벨들 변수값 설정해서 연산 프로퍼티로 변경될 메서드들을 수행할 수 있도록 한다.(근데 굳이 함수를 쓰지않고 연산 프로퍼티에서도 변경해줘도 될 것같다....)
        // 나중에 리셋버튼을 누르게되면 사용할 수도 있으니 함수는 일단 살려놓는것으로 하자.
        setLabelsByWeatherInformation(latitude: 37.547750, longitude: 126.942186)
    }
    
    // 오늘날짜 설정
    func setDateLabel() {
        // dateformatter를 가지고 형식에 맞게 날짜 받아옴
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일 HH시 MM분"
        let todayDate = dateFormatter.string(from: Date())
        
        dateLabel.text = todayDate
    }
    
    // 이 함수의 파라미터를 Any로 바꾸니 오류가 발생
    // 아래 함수와 같이 중복되는 코드 사용을 지양해야하는데 지금은 방법을 모르겠음
    func setBasicEnvironmentLabel(_ label: UILabel) {
        label.clipsToBounds = true
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
    }
    
    func setImageView(_ imageView: UIImageView) {
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 10
    }
    
    // 온도 설정
    func setTemperatureLabel(_ temperature: Int) {
        temperatureLabel.text = "지금은 " + String(temperature) + "도 에요."
    }
    
    // 습도 설정
    func setHumidityLabel(_ humidity: Int) {
        humidityLabel.text = String(humidity) + "%만큼 습해요"
    }
    
    // 풍속 설정
    func setWindLabel(_ wind: Int) {
        windLabel.text = String(wind) + "m/s만큼 바람이 불어요."
    }
    
    // 좋은하루 보내세요 설정
    func setGoodDayLabel() {
        goodDayLabel.text = "오늘도 좋은 하루 보내세요"
    }
    
    // 날씨 이미지뷰 설정
    func setWeatherImageView(_ imageStr: String) {

        let urlSource = "http://openweathermap.org/img/wn/" + imageStr + "@2x.png"

        //url에 정확한 이미지 url 주소를 넣는다.
        let url = URL(string: urlSource)
        do {
            let image = try Data(contentsOf: url!)
            print(image)
            weatherImageView.image = UIImage(data: image)
        }
        catch {

        }
    }
    
    // http정보 받아옴(현재 내 위치에서 받아올것인지 확인해보기)
    // 37.547750
    // 126.942186
    func setLabelsByWeatherInformation(latitude: Double, longitude: Double) {
        // URL정보를 생성
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=" + String(latitude) + "&lon=" + String(longitude) + "&appid=" + key
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                // 온도
                print(json["main"]["temp"])
                self.temperature = json["main"]["temp"].intValue
                // 습도
                print(json["main"]["humidity"])
                self.humidity = json["main"]["humidity"].intValue
                // 풍속
                print(json["wind"]["speed"])
                self.wind = json["wind"]["speed"].intValue
                // 이미지(자세히 보니 배열타입이라 0번 인덱스의 값을 가져와줌
                print(json["weather"][0]["icon"])
                self.imageLink = json["weather"][0]["icon"].stringValue
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
