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

struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}

class NetworkingViewController: UIViewController {
    
    let urlString = "https://aztro.sameerkumar.website/?sign=aries&day=today"
    let lottoURL = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=903"
    
    let disposeBag = DisposeBag()
    
    let label = UILabel()
    
    let number = BehaviorSubject<String>(value: "오늘의 운세")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
//        number
//            .bind(to: label.rx.text)
//            .disposed(by: disposeBag)
        
        number
            .bind(to: label.rx.text)    // 아래 두개를 처리할 수 있다.
//            .observe(on: MainScheduler.instance)    // 메인스레드에서 호출이 된다
//            .subscribe { value in
//                self.label.text = value
//            }
            .disposed(by: disposeBag)
        
        let request = useURLSession()
            .share()    // Drive에 내장되어있어서 한번만 호출이 된다.
            .decode(type: Lotto.self, decoder: JSONDecoder())   //decode를 해야한다.
        
        request
            .subscribe { value in
                print("value1")
                print(Thread.isMainThread)
                
//                self.number.onNext(value.element.drwNoDate)
            }
            .disposed(by: disposeBag)
        
        request
            .subscribe { value in
                print("value2")
                print(Thread.isMainThread)
//                self.number.onNext(value.element.drwNoDate)
            }
            .disposed(by: disposeBag)
    }
    
    func rxAlamofire() {
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
    func useURLSession() -> Observable<Data> {
        return Observable.create { value in
            let url = URL(string: self.lottoURL)!
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    value.onError(ExampleError.fail)
                    return
                }
                
                // response, data json, encoding 생략
                if let data = data {
                    print("datatask")
                    value.onNext(data)
                }
                
                value.onCompleted()
            }
            task.resume()
            
            return Disposables.create() {
                task.cancel()
            }
        }
    }
    
    func setup() {
        view.backgroundColor = .white
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
