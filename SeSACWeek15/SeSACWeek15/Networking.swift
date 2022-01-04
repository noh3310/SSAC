//
//  Networking.swift
//  SeSACWeek15
//
//  Created by 노건호 on 2022/01/04.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire
import SnapKit

class NetworkingViewController: UIViewController {
    
    let urlString = "https://aztro.sameerkumar.website/?sign=aries&day=today"
    let lottoURL = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=903"
    
    let disposeBag = DisposeBag()
    
    let label = UILabel()
    
    let number = BehaviorSubject<String>(value: "오늘의 운세")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        number
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        
//        json(.get, lottoURL)
//            .subscribe { value in
//                print(value)
//            } onError: { error in
//                print(error)
//            } onCompleted: {
//                print("completed")
//            } onDisposed: {
//                print("OnDisposed")
//            }
//            .disposed(by: disposeBag)
        
        json(.post, urlString)
            .subscribe { value in
                print(value)
                
                guard let data = value as? [String: Any] else { return }
                guard let result = data["lucky_number"] as? String else { return }
                print("==\(result)")
                self.number.onNext(result)
                
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("OnDisposed")
            }
            .disposed(by: disposeBag)
    }
    
    // 함수에 대한 리턴이 어떻게 오느냐에 따라서 리턴값이 설정되기 때문에
    func useURLSession(url: String) -> Observable<String> {
        return Observable.create { value in
            let url = URL(string: self.lottoURL)!
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    value.onError(ExampleError.fail)
                    return
                }
                
                // response, data json, encoding 생략
                if let data = data, let json = String(data: data, encoding: .utf8) {
                    value.onNext("\(data)")
                }
                
                value.onCompleted()
            }
            task.resume()
            
            return Disposables.create() {
                task.cancel()
            }
        }
    }
    
}
