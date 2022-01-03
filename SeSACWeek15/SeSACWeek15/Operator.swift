//
//  Operator.swift
//  SeSACWeek15
//
//  Created by 노건호 on 2022/01/03.
//

import UIKit
import RxSwift

enum ExampleError: Error {
    case fail
}

class Operator: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = [3.3, 2.8, 4.0, 5.0, 3.6, 4.8]
        let itemsB = [2.3, 2.0, 1.3]
        
        // just는 하나밖에 못쓴다.
        Observable.just(items)
            .subscribe { value in
                print(value)
            }
            .disposed(by: disposeBag)
        
        // of는 2개도 넣을 수 있다.
        Observable.of(items, itemsB)
            .subscribe { value in
                print(value)
            }
            .disposed(by: disposeBag)
        
        // 배열 값 하나하나에 접근할 수 있도록 하기위해 이렇게 처리함
        Observable.from(items)
            .subscribe { value in
                print(value)
            }
            .disposed(by: disposeBag)
        
        // Observable<Element>
        Observable<Double>.create { observer -> Disposable in
            for i in items {
                if i < 3.0 {
                    observer.onError(ExampleError.fail)
                }
                observer.onNext(i)
            }
            observer.onCompleted()
            
            return Disposables.create()
        }
        .subscribe { value in
            print(value)
        } onError: { error in
            print(error)
        } onCompleted: {
            print("completed")
        } onDisposed: {
            print("disposed")
        }
        .disposed(by: disposeBag)

        
    }
    
}
