//
//  NASAViewController.swift
//  SeSAC_Week13
//
//  Created by 노건호 on 2021/12/22.
//

import UIKit

class NASAViewController: BaseViewController {
    
    let imageView = UIImageView()
    var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            label.text = String(result * 100) + "%"
        }
    }
    var total: Double = 0
    var label = UILabel()
    
    var session: URLSession! // 강한 참조로 이루어져있다고 한다.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        buffer = Data()
        request()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 화면 없어지려고 할 때는 이미지처리 취소
        // 리소스 정리, 실행중인 태스크가 있더라도 그만함.
        session.invalidateAndCancel()
    }
    
    override func configure() {
        super.configure()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        label.textAlignment = .center
        label.backgroundColor = .white
        label.textColor = .black
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        view.addSubview(imageView)
        view.addSubview(label)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(100)
        }
        label.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
    
    func request() { // 3MB 20MB
        let url = URL(string: "https://apod.nasa.gov/apod/image/2112/WinterSolsticeMW_Seip_2980.jpg")!
        
//        URLSessionConfiguration.default
        
        let configuration = URLSessionConfiguration.default
        // 셀룰러일때는 다운안받게 설정
        configuration.allowsCellularAccess = false
        
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        // default로 보내고, delegate는 self, delegateQueue는 메인스레드에서 실행된다.
        session?.dataTask(with: url)
//        URLSession(configuration: .default, delegate: self, delegateQueue: .main).dataTask(with: url).resume()
        
//        URLSession.shared.dataTask(with: url).resume()
    }
    
}

extension NASAViewController: URLSessionDataDelegate {
    
    // 서버에서 최초로 응답 받은 경우 호출
    // 보통 헤더를 받을 수 있다.
    // 상태코드로 처리를 해볼 수 있다(200~500)
    // 클라이언트에 데이터가 쪼개져서 보내진다. 헤더먼저 보내진다고 생각하면 된다.
    //
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
            let dataLength = response.value(forHTTPHeaderField: "Content-Length")
            print(dataLength)
            label.text = dataLength
            total = Double(dataLength!)!
            return .allow
        } else {
            return .cancel
        }
    }
    
    // 서버에서 데이터를 받을 때마다 반복적으로 호출됨
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
//        print(data)
        buffer?.append(data)
    }
    
    // 응답이 완료되었을 때: nil
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print("오류 발생", error)
        } else {
            print("성공!") // compleetionHandler
            
            // bufferdp Data가 모두 채워졌을 떄, 이미지로 변환
            guard let buffer = buffer else {
                print("buffer error")
                return
            }
            
            let image = UIImage(data: buffer)
            imageView.image = image
        }
    }
    
}
