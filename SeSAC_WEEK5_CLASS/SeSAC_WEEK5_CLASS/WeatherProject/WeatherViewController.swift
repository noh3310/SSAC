//
//  WeatherViewController.swift
//  SeSAC_WEEK5_CLASS
//
//  Created by 노건호 on 2021/10/25.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class WeatherViewController: UIViewController {
    
    static let identifier = "WeatherViewController"
    
    // Key값은 gitignore로 가려줌
    let key = Key.weatherKey
    
    // 온도 담아놓는 변수
    var temperature: Double = 0 {
        didSet {
            setTemperatureLabel(self.temperature)
        }
    }
    
    // 습도 담아두는 변수
    var humidity: Int = 0 {
        didSet {
            setHumidityLabel(self.humidity)
        }
    }
    
    // 풍속 변수
    var wind: Double = 0 {
        didSet {
            setWindLabel(self.wind)
        }
    }
    
    // 이미지링크 주소
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
        dateLabel.textColor = .white
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
    func setTemperatureLabel(_ temperature: Double) {
        // 캘빈 -> 섭씨로 변경
        let celsiusValue = changeKelvinToCelsius(temperature)
        
        // 소수점 둘째자리까지 잘라주기
        let stringCelsius = calculateTwoDecimalPlaces(celsiusValue)
        
        temperatureLabel.text = "지금은 " + stringCelsius + "°C 에요."
    }
    
    // 캘빈 -> 섭씨 변환 함수
    func changeKelvinToCelsius(_ kelvin: Double) -> Double {
        return kelvin - 273.15
    }
    
    // 습도 설정
    func setHumidityLabel(_ humidity: Int) {
        humidityLabel.text = String(humidity) + "%만큼 습해요 "
    }
    
    // 풍속 설정
    func setWindLabel(_ wind: Double) {
        let windString = calculateTwoDecimalPlaces(wind)
        
        windLabel.text = windString + "m/s만큼 바람이 불어요."
    }
    
    // 좋은하루 보내세요 설정
    func setGoodDayLabel() {
        goodDayLabel.text = "오늘도 좋은 하루 보내세요"
    }
    
    // 소수점 두자리수까지 계산해서 리턴해주는 함수
    func calculateTwoDecimalPlaces(_ value: Double) -> String {
        return String(format: "%.2f", value)
    }
    
    // 날씨 이미지뷰 설정
    func setWeatherImageView(_ imageStr: String) {
        
        let urlSource = "http://openweathermap.org/img/wn/" + imageStr + "@2x.png"
        
        // Kingfisher 적용(편안...)
        let url = URL(string: urlSource)
        weatherImageView.kf.setImage(with: url)
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
                self.temperature = json["main"]["temp"].doubleValue
                // 습도
                print(json["main"]["humidity"])
                self.humidity = json["main"]["humidity"].intValue
                // 풍속
                print(json["wind"]["speed"])
                self.wind = json["wind"]["speed"].doubleValue
                // 이미지(자세히 보니 배열타입이라 0번 인덱스의 값을 가져와줌
                print(json["weather"][0]["icon"])
                self.imageLink = json["weather"][0]["icon"].stringValue
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
