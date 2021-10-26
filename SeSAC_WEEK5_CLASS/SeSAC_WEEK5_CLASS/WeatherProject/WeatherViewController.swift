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
import CoreLocation
import CoreLocationUI

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
    
    var windDirection: Int = 0 {
        didSet {
            setWindDirection(self.windDirection)
        }
    }
    
    // 이미지링크 주소
    var imageLink: String = "" {
        didSet {
            setWeatherImageView(self.imageLink)
        }
    }
    
    // 주소이름: ~구 ~동 까지만 나옴
    var addressName: String = "" {
        didSet {
            // 현재위치 업데이트된것을 라벨에 반영해줌(일단은 위경도만 출력)
            updateCurrentPositionLabel()
        }
    }
    
    // 기본값을 일단은 싹 영등포캠퍼스로 설정해줌
    // 37.51778532586968, 126.88643025525303
    var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 20, longitude: 20) {
        // 만약 값이 변한다면 어떻게 할지 결정해보기
        didSet {
            // 위도 경도를 주소로 변환
            changePositionToAddress(self.userLocation)
            
            // 새롭게 API로 정보를 가져와서 업데이트해줌
            setLabelsByWeatherInformation(latitude: self.userLocation.latitude, longitude: self.userLocation.longitude)
        }
    }
    
    // 1. CLLocationManager 변수를 선언
    // 앱 위치관련 이벤트를 실행할지, 실행하지 않을지 결정하는 오브젝트
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var uiView: UIView!
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
        
        // 2. locationManager 델리게이트 권한 위임
        locationManager.delegate = self
        
        // 바람 방향 이미지 설정
        setWindArrowImageView()
        
        // 오늘날짜 설정
        setDateLabel()
        
        // 라벨환경변수 설정(모두다 같아서 하나로 묶어줌)
        setBasicEnvironmentLabel(temperatureLabel)
        setBasicEnvironmentLabel(humidityLabel)
        setBasicEnvironmentLabel(windLabel)
        setBasicEnvironmentLabel(goodDayLabel)
        
        // 이미지뷰 환경설정
        setImageView(weatherImageView)
        
        // 현재위치 기본설정
        setUpdateCurrentPositionLabel()
        
        // 좋은하루 되세요 설정
        setGoodDayLabel()
        
        // uiView 설정
        uiView.backgroundColor = .clear
        
        // 버튼 설정
        setButtonOf(shareButton, imageString: "square.and.arrow.up")
        setButtonOf(refreshButton, imageString: "arrow.clockwise")
    }
    
    // 오늘날짜 설정
    func setDateLabel() {
        // dateformatter를 가지고 형식에 맞게 날짜 받아옴
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일 HH시 mm분"
        let todayDate = dateFormatter.string(from: Date())
        
        dateLabel.text = todayDate
        dateLabel.textColor = .white
    }
    
    // 이미지뷰 기본 설정
    func setWindArrowImageView() {
        windArrowImageView.image = UIImage(systemName: "paperplane.fill")
        windArrowImageView.tintColor = .white
    }
    
    // positionLabel 텍스트 색상 설정
    func setUpdateCurrentPositionLabel() {
        currentPosition.textColor = .white
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
    
    // 방향을 정해줌(바람의 방향은 Direction으로 알려줌(meteorological))
    // 검색해보니 8가지로 나눌 수 있다 아래 그림보고 참조해서 만듬
    // https://uni.edu/storm/Wind%20Direction%20slide.pdf
    func setWindDirection(_ windDirection: Int) {
        // 그림을 기본적으로 위를 바라보게 해놓고 그다음에 계산하면 된다.
        let angle: CGFloat = CGFloat((windDirection + 318) % 360) * .pi / 180
        windArrowImageView.transform = .init(rotationAngle: angle)
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
                // 바람 방향
                print("windDirection = \(json["wind"]["deg"])")
                self.windDirection = json["wind"]["deg"].intValue

            case .failure(let error):
                print(error)
            }
        }
    }
    
    // 버튼 설정
    func setButtonOf(_ button: UIButton, imageString: String) {
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: imageString), for: .normal)
        button.tintColor = .white
    }
    
    // 유저상태 설정(만약 설정되면 연산 프로퍼티로 메서드 실행할 것)
    func setUserLocation() {
        // 위경도를 옵셔널 바인딩으로 가져옴
        guard let latitude = locationManager.location?.coordinate.latitude else { return }
        guard let longitude = locationManager.location?.coordinate.longitude else { return }
        
        // CLLocationCoordinate2D 새롭게 생성
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        // 유저정보 넣어줌
        self.userLocation = location
    }
    
    // 현재위치가 변경되었을 때 라벨값 업데이트(추후 위경도 -> 주소 동 까지만 출력으로 변경)
    // 애플 API 사용
    func updateCurrentPositionLabel() {
        currentPosition.text = addressName
    }
    
    // 리프레쉬 버튼 클릭했을 때 내 위치를 새롭게 받아옴
    @IBAction func refreshButtonClicked(_ sender: UIButton) {
        setUserLocation()
    }
    
    // 위경도를 주소이름으로 변경해줌
    func changePositionToAddress(_ location: CLLocationCoordinate2D) {
        
        //latitude: 위도, 도: 경도
        let findLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr") //원하는 언어의 나라 코드를 넣어주시면 됩니다.
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
            guard let address: [CLPlacemark] = placemarks else { return }
            guard let administrativeArea: String = address.first?.administrativeArea else { return }
            guard let locality: String = address.first?.locality else { return }
            
            let addressName = "\(administrativeArea) \(locality)"
            self.addressName = addressName
        })
    }
    
    // 현재 위치정보를 사용하고 있다면 이미지 보이고, 아니라면 안보이게 설정
    // 이건 나중에 하자...
    func setCurrentPositionStateImageLabel(_ bool: Bool) {
        
    }
}

// 3. 익스텐션 설정
extension WeatherViewController: CLLocationManagerDelegate {
    
    // 4. 사용자가 위치를 업데이트 했을 때 실행되는 부분(여기에서 현재 위치를 업데이트 해줌
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        
        // 옵셔널바인딩으로 값이 들어있는지 확인함
        if let location = locations.first {
            // 변수의 값을 변경해주면서 연산 프로퍼티로 위치를 업데이트해주는 함수가 수행될 수 있도록 설정해줌
            userLocation = location.coordinate
        }
    }
    
    // 5. 만약 위치서비스 에러가 발생했다면
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
        print("오류발생")
    }
    
    // 6. 앱이 위치 관리자를 생성하고, 승인상태가 변경이 될 때 대리자에게 승인 상태를 알려줌
    // iOS 14 이상부터 사용
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserLocationServiceAuthorization()
    }
    
    // 7. 앱이 위치 관리자를 생성하고, 승인상태가 변경이 될 때 대리자에게 승인 상태를 알려줌
    // iOS 14에서 Deprecated됨
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        checkUserLocationServiceAuthorization()
    }
    
    // 8. iOS 버전에 따른 분기 처리와 iOS 위치 서비스 여부 확인
    func checkUserLocationServiceAuthorization() {
        // 위치 관리자의 델리게이트 함수에서 승인 상태 변경을 처리하는 Enum
        var authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        // 위치서비스가 이용가능하다면 그제서야 사용자가 권한설정을 했는지 확인할 수 있다.
        if CLLocationManager.locationServicesEnabled() {
            // 권한상태 확인 및 요청가능
            checkCurrentLocationAuthorization(authorizationStatus)
        } else {
            // 이건 나중에 설정화면으로 갈 수 있도록 설정할 수 있을것 같다.
            print("위치서비스를 켜주세요.")
        }
    }
    
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        print(#function)
        
        switch authorizationStatus {
            // 결정되지 않았을 때
        case .notDetermined:
            // 앱이 원하는 위치의 정확도를 물어봄, kCLLocationAccuracyBest는 매우 정확한 정확도
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            // 앱을 사용할때 위치정보를 허용할 것인지 요청함
            locationManager.requestWhenInUseAuthorization()
            // 사용자의 현재 위치를 보고하는 업데이트 생성을 시작한다.
            locationManager.startUpdatingLocation()
            
            // 이때 사용자의 현재위치를 받아옴
            setUserLocation()
        case .restricted, .denied:
            print("설정으로 유도")
        case .authorizedAlways:
            print("always")
        case .authorizedWhenInUse:
            print("위치접근 가능")
            // 사용자의 현재 위치를 보고하는 업데이트 생성을 시작한다.
            locationManager.startUpdatingLocation()
            
            // 이때 사용자의 현재위치를 받아옴
            setUserLocation()
        @unknown default:
            print("default")
        }
        
        // 앱의 정확도를 표시했을 때 어떻게 실행되는지 설정
        if #available(iOS 14.0, *) {
            // 사용자가 설정한 위치 정확도를 의미함
            let accuracyState = locationManager.accuracyAuthorization
            
            switch accuracyState {
            case .fullAccuracy:
                print("fullAccuricy")
            case .reducedAccuracy:
                print("reducedAccuracy")
            @unknown default:
                print("unknown default")
            }
        }
    }
}
