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
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Observable: 상황에 대한 전달만 해준다. 어떻게 할지는 모르고 일단 값만 전달한다.
        // 이벤트를 처음 생성할 때 나오는것은 Create
        Observable.from(["가", "나", "다", "라", "마"])
            .subscribe { value in
                print(value)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")   // 메모리가 정리되었을 때 실행이 된다.
            }
            .disposed(by: disposeBag)   // dispose 해줘야함

        Observable<Int>.interval(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe { value in
                print(value)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")   // 메모리가 정리되었을 때 실행이 된다.
            }
            .disposed(by: disposeBag)   // dispose 해줘야함
        
        Observable.repeatElement("Jack")
            .take(Int.random(in: 1...10))
            .subscribe { value in
                print(value)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")   // 메모리가 정리되었을 때 실행이 된다.
            }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            self.navigationController?.pushViewController(GradeCalculator(), animated: true)
//            intervalObservable.dispose()
//            repeatObservable.dispose()
            self.disposeBag = DisposeBag()  // 프로퍼티가 가지고있는 모든 Observable이 새 인스턴스로 교체가 된다. 그러면 dispose는 다 종료가 된다. 그러면 모든 옵저버가 종료가 된다. ㄷㄷ
            self.present(GradeCalculator(), animated: true, completion: nil)
//            self.dismiss(animated: true, completion: nil)
        }
    }
    
    deinit {
        print("Operator Deinit")
    }
    
    func basic() {
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
