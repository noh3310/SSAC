//
//  MovieMapViewController.swift
//  TrendMedia
//
//  Created by 노건호 on 2021/10/20.
//

import UIKit
import MapKit
import CoreLocation
import CoreLocationUI // iOS 15 LocationButton

class MovieMapViewController: UIViewController {
    
    static let identifier = "MovieMapViewController"
    
    @IBOutlet weak var mapView: MKMapView!
    
    let mapList = Sample.mapAnnotations
    
    // 1. 일단 CLLocationManager 변수를 선언
    // 위치 관련한 이벤트 처리를 하는 컨트롤러
    let locationManager = CLLocationManager()
    
    var type = "전체보기" {
        didSet {
            printAnnotation(printType: self.type)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 2. locationManager 델리게이트 연결
        locationManager.delegate = self
        
        // mapView 델리게이트 연결
        mapView.delegate = self
 
        // 지도 위치랑, 어노테이션 설정
        printAnnotation(printType: type)
        
        // 네비게이션 바 설정
        setNavigationBar()
    }
    
    func setNavigationBar() {
        // 네비게이션바 오른쪽에 버튼 생성
        let rightBarButton = UIBarButtonItem.init(title: "Type", style: .done, target: self, action: #selector(filterButtonClicked(_:)))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    // 어노테이션 출력및 중간위치 설정(이것도 나중에 함수 여러개로 변경할 수 있음)
    func printAnnotation(printType: String) {
        // 맵뷰에 있는 어노테이션 일단 다 삭제
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        
        var xPosition: Double = 0
        var yPosition: Double = 0
        var divNum = 0
        
        // 맵리스트에 위치 나오게 해줌
        for mapList in mapList {
            if printType == mapList.type || printType == "전체보기" {
                let annotation = MKPointAnnotation()
                annotation.title = mapList.location
                
                let location = CLLocationCoordinate2D(latitude: mapList.latitude, longitude: mapList.longitude)
                annotation.coordinate = location
                mapView.addAnnotation(annotation)
                
                xPosition += mapList.latitude
                yPosition += mapList.longitude
                divNum += 1
            }
        }
        xPosition /= Double(divNum)
        yPosition /= Double(divNum)
        
        // 이제 mapView에 Annotation을 찍는 과정을 수행함
        let location = CLLocationCoordinate2D(latitude: xPosition, longitude: yPosition)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    // 필터 버튼 클릭했을 때
    @objc func filterButtonClicked(_ button: UIButton) {
        let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .actionSheet)
        
        let lotteCinema = UIAlertAction(title: "롯데시네마", style: .default) { _ in
            self.type = "롯데시네마"
        }
        
        let megabox = UIAlertAction(title: "메가박스", style: .default) { _ in
            self.type = "메가박스"
        }
        
        let cgv = UIAlertAction(title: "CGV", style: .default) { _ in
            self.type = "CGV"
        }
        
        let all = UIAlertAction(title: "전체보기", style: .default) { _ in
            self.type = "전체보기"
        }
        
        alert.addAction(lotteCinema)
        alert.addAction(megabox)
        alert.addAction(cgv)
        alert.addAction(all)
        
        self.present(alert, animated: true)
    }
}

extension MovieMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(#function)
        print("aaaa")
    }
}

// 3. 익스텐션 설정
extension MovieMapViewController: CLLocationManagerDelegate {
    
    // 4. 사용자가 위치 허용을 했을 떄 실행되는 부분
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        
        if let coordinate = locations.last?.coordinate {
            // Map에 pin을 찍어주는 것
            
            let annotation = MKPointAnnotation()
            annotation.title = "현재 위리"
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
            
            let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            // 맵뷰에 어노테이션을 지우려면 이것을 사용하면 된다.
            let annotations = mapView.annotations
            mapView.removeAnnotations(annotations)
            
            // 10. (중요) 사용자가 위치를 계속 업데이트한다면 비효율적이므로 위치업데이트를 멈춰줘야 한다.
            // startUpdatingLocation과 stopUpdatingLocation과 짝이라고 생각하면 된다.
            locationManager.stopUpdatingLocation()
        }
        else {
            print("location Can Not Find")
        }
    }
    
    // 5. 위치설정은 했으나 오류로 인해서 실행되지 않은 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
        print("잠시 후 다시 시도해주세요")
    }
    
    /// 6, 7번은 앱을 실행할 때 한번만 실행되고, 권한사항이 바뀔 때 실행됨
    // 6. 앱이 위치 관리자를 생성하고, 승인 상태가 변경이 될 때 대리자에게 승인 상태를 알려줌
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
    
    // 7. 앱이 위치 관리자를 생성하고, 승인 상태가 변경이 될 때 대리자에게 승인 상태를 알려줌
    // 그런데 이건 iOS 14에서부터 안쓰여지고 6번이 쓰여짐
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
    
    // 새롭게 그냥 만든 함수
    // 8. iOS 버전에 따른 분기 처리와 iOS 위치 서비스 여부 확인
    func checkUserLocationServicesAuthorization() {
        print(#function)
        // 위치 서비스에 대한 앱의 인증을 나타내는 Enum
        var authorizationStatus: CLAuthorizationStatus
        
        // 사용자가 위치서비스를 허용했는지, 안했는지 정보를 담고 있음
        if #available(iOS 14.0, *) {
            // 아래 코드는 iOS 14에서만 사용가능
            authorizationStatus = locationManager.authorizationStatus
        } else {
            // iOS 14이전에서 사용자 위치서비스 허용했는지 정보를 받아오는 방법
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        // iOS 위치서비스 확인
        // 위치서비스가 이용가능하면 그제서야 권한확인을 할 수 있다.
        if CLLocationManager.locationServicesEnabled() {
            // 권한상태 확인 및 요청가능
            checkCurrentLocationAuthorization(authorizationStatus)
        }
        else {
            print("위치서비스를 켜주세요")
        }
    }
    
    // 9. 사용자 위치 권한 확인
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        print(#function)
        
        // 위치서비스에 대한 상황에 따라 처리하기 위해 switch 사용
        switch authorizationStatus {
        case .notDetermined:
            // 앱이 원하는 정확도를 물어봄(자세한 위치켜고 끄는 기능) kCLLoationAccuracyBest는 매우 높은 정확도를 나타냄
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            // 앱을 사용중일 때 위치정보를 사용하기 위한 요청(Request)
            locationManager.requestWhenInUseAuthorization()
            // 위치접근 시작 -> didUpdateLocation을 실행함
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
            print("DENIED 설정으로 유도")
        case .authorizedWhenInUse:
            print("위치접근 가능")
            // 위치접근 시작 -> didUpdateLocation을 실행함
            locationManager.startUpdatingLocation()
        case .authorizedAlways:
            print("always")
        @unknown default:
            print("Default")
        }
        
        // 권한을 만든다음 세부적인 내용들을 나눠줘야 한다.
        // 정확도가 감소되어 있는 경우에 동작하지 않는 기능들이 있다.
        // 정확도가 감소되어 있는 경우 아무리 실시간으로 위치되어 있다고 하더라도 1시간에 4번밖에 보내지 않는다. 또는 미리알림이 안가게 될 수 있다.
        //
        
        if #available(iOS 14.0, *) {
            let accurateState = locationManager.accuracyAuthorization
            
            switch accurateState {
            case .fullAccuracy:
                print("fullAccuracy")
            case .reducedAccuracy:
                print("reduceAccuracy")
            @unknown default:
                print("Default")
            }
        }
    }
}
