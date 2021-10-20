//
//  LocationViewController.swift
//  SeSAC_04_Week
//
//  Created by 노건호 on 2021/10/20.
//

import UIKit
import MapKit
import CoreLocation
import CoreLocationUI // iOS 15 LocationButton

/*
 1. 설정으로 유도하는 화면 구현해볼 계획
 2. 위경도 -> 주소로 변환
 3. 반복문을 통해서 annotation을 해주거나 하면 된다.
 */

class LocationViewController: UIViewController {
    
    static let identifier = "LocationViewController"
    
    @IBOutlet weak var userCurrentLocationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    // 1. 위치 관련한 기능을 가져오면 된다.
    // CoreLocation안에 기능이 다 있다.
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        /// 지역을 설정한 부분
        // 37.51784489395558, 126.88637661107809
        let location = CLLocationCoordinate2D(latitude: 37.51784489395558, longitude: 126.88637661107809)
        // 축척 정보
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        // 맵뷰 어노테이션을 설정하는 부분
        let annotation = MKPointAnnotation()
        annotation.title = "Here"
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        
        mapView.delegate = self
        
        // 다양한 클릭관련 이벤트는 델리게이트 패턴으로 할 수 있음
        
        
        // 2. Delegate를 연결
        locationManager.delegate = self
    }

}

extension LocationViewController: MKMapViewDelegate {
    
    // 앱 어노테이션 클릭 시 이벤트
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("aaaa")
    }
}

// 3. 익스텐션 설정
extension LocationViewController: CLLocationManagerDelegate {
    
    // 9. iOS 버전에 따른 분기 처리와 iOS 위치 서비스 여부 확인
    func checkUserLocationServicesAuthorization() {
        
        // 사용자의 상태를 들고있을 수 있는 변수
        let authorizationStatus: CLAuthorizationStatus
        
        // 사용자가 허용안함을 ㅇ누르지 않은상태, 실행한 상태등을 담고 있음
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus // iOS 14 이상에만 사용 가능하다.
        }
        else {
            authorizationStatus = CLLocationManager.authorizationStatus() // iOS 14에서 deprecate됨
        }
        
        // iOS 위치 서비스 확인
        // 위치서비스가 이용가능하면 그제서야 권한확인을 할 수 있다.
        if CLLocationManager.locationServicesEnabled() {
            // 권한 상태 확인 빛 권한 요청 가능
            checkCurrentLocationAuthorization(authorizationStatus)
        }
        else {
            print("iOS 위치 서비스를 켜주세요")
        }
    }
    
    // 8. 사용자워 권한 상태 확인(UDF. 사용자 정의 함수로 프로토콜 내 메서드가 아님)
    // 사용자가 위치를 허용했는지 안했는지 거부한건지 이런 권한을 확인(단, iOS의 위치 서비스가 켜져있는지 확인하는 작업이 선행되어야 함)
    func checkCurrentLocationAuthorization(_ aurhorizationStatus: CLAuthorizationStatus) {
        switch aurhorizationStatus {
        case .notDetermined:
            // 정확한 위치를 얻을 때 반경을 설정하는 방법, 너무 정확하게 해도 배터리가 많이 쓰인다, 애플워치는 정확하게, 아이폰은 조금 덜 정확하게 함
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() // 앱을 사용하는 동안에 대한 위치 권한 요청
            locationManager.startUpdatingLocation() // 위치 접근 시작 => didUpdateLocation을 실행함
        case .restricted, .denied:
            print("DENIED, 설정으로 유도")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation() // 위치 접근 시작
        case .authorizedAlways:
            print("Always")
        @unknown default:
            print("DEFAULT")
        }
        
        // 권한을 요청한 다음에 세부적인 내용들을 나눠줘야 한다.
        // 정확도가 감소되어있는 경우에 동작하지 않은 기능들이 있다.
        // 정확도가 감소되어있을 경우에 아무리 실시간으로 위치를 달라고 한다고 하더라도 1시간에 4번을 보내게 된다, 또는 미리알림이 안가게 될 수도 있다.
        // 배터리에 영향을 미치게될 수 있다.
        // 이번에 나온 애플워치 버전이 동기화가 된다고 한다.
        if #available(iOS 14.0, *) {
            let accuranceState = locationManager.accuracyAuthorization
            
            switch accuranceState {
            case .fullAccuracy:
                print("FULL")
            case .reducedAccuracy:
                print("REDUCE")
            @unknown default:
                print("DEFAULT")
            }
        }
    }
    
    // 4. 사용자가 위치 허용을 한 경우에 실행이 뒤는 부분
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        print(locations)
        // 점점 가까운 위치를 세부적으로 잡는다고 한다.
        // 마지막 배열에 있는 경우에
        if let coordinate = locations.last?.coordinate {
            // Map에 pin을 찍어주는 것
            
            let annotation = MKPointAnnotation()
            annotation.title = "현재 위리"
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
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
    
    // 5. 위치허용을 했으나 이슈로 인해 위치연결에 실패하는 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("잠시 후 다시 시도해주세요")
    }
    
    /// 6, 7번은 앱을 실행할 때 한번 실행되고, 권한사항이 바뀔 때 실행됨
    // 6. iOS 14 미만: 앱이 위치 관리자를 생성하고, 승인 상태가 변경이 될 때 대리자에게 승인 상태를 알려줌
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
    
    // 7. iOS 14 이상: 앱이 위치 관리자를 생성하고, 승인 상태가 변경이 될 때 대리자에게 승인 상태를 알려줌
    // 정확도가 들어오게 되면서 바뀌게 되었다.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
}
