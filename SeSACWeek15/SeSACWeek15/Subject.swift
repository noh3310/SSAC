//
//  Subject.swift
//  SeSACWeek15
//
//  Created by 노건호 on 2022/01/04.
//

import UIKit
import RxSwift

class SubjectViewController: UIViewController {
    
    let label = UILabel()
    
//    let nickname = Observable.just("JACK")
    let nickname = PublishSubject<String>() // Observable을 수정할 수 있도록 설정
    
    let disposeBag = DisposeBag()
    
    let array1 = [1, 2, 3, 4, 5, 6]
    let array2 = [2, 3, 4, 5, 6, 7]
    let array3 = [3, 4, 5, 6, 7, 8]
    let subject = PublishSubject<[Int]>()
    
    let behavior = BehaviorSubject<[Int]>(value: [0,0,0,0,1])    // PublishSubject과는 다르게 초기값을 가진다.
    
    let replay = ReplaySubject<[Int]>.create(bufferSize: 4)     // 메모리 개수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let random1 = Observable<Int>.create { observer in
            observer.onNext(Int.random(in: 1...100))
            observer.onNext(Int.random(in: 1...100))
            observer.onNext(Int.random(in: 1...100))
            return Disposables.create()
        }

        random1
            .subscribe { value in
            print("random1 \(value)")
            }
            .disposed(by: disposeBag)
        
        random1
            .subscribe { value in
            print("random2 \(value)")
            }
            .disposed(by: disposeBag)
        
        let randomSubject = BehaviorSubject(value: 0)
        randomSubject.onNext(Int.random(in: 1...100))
        
        randomSubject
            .subscribe { value in
            print("randomSubject1 \(value)")
            }
            .disposed(by: disposeBag)
        
        
        randomSubject
            .subscribe { value in
            print("randomSubject2 \(value)")
            }
            .disposed(by: disposeBag)
   
        setup()
//        replaySubject()
//        behaviorSubject()
//        publishSubject()
//        aboutSubject()
    }
    
    func replaySubject() {
        replay.onNext(array1)
        replay.onNext(array2)
        replay.onNext(array3)
        replay.onError(ExampleError.fail)
        replay.onNext(array1)

        replay
            .subscribe { value in
                print("behavior subject - \(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("oncompleted")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
        
        replay.onNext(array1)
    }
    
    func behaviorSubject() {
        behavior.onNext(array1)
        behavior.onNext(array2)
        behavior.onNext(array3)
        
        behavior
            .subscribe { value in
                print("behavior subject - \(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("oncompleted")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
        
        behavior.onNext(array1)
        behavior.onNext(array2)
        behavior.onCompleted()
        
        behavior.onNext(array1) // 완료된 시점 이후에는 전달하지 않음
    }
    
    func publishSubject() {
        subject.onNext(array1)  // 구독하기전에 이벤트를 전달했기 때문에 실행 안됨
        
        subject.subscribe { value in
            print("publish subject - \(value)")
        } onError: { error in
            print(error)
        } onCompleted: {
            print("oncompleted")
        } onDisposed: {
            print("disposed")
        }
        .disposed(by: disposeBag)

        subject.onNext(array2)  // 구독한 다음에 이벤트를 전달했기 때문에 실행 됨
        subject.onNext(array3)
        subject.onCompleted()
        
        subject.onNext(array1)  // 완료가 된 시점 이후에는 실행이 되지 않는다.
        
    }
    
    func aboutSubject() {   // 따로 정리하기
        nickname
            .bind(to: label.rx.text)  // subscribe vs bind
            .disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.nickname.onNext("ddd")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.nickname.onNext("aaaaaa")
        }
    }
    
    func setup() {
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        label.backgroundColor = .white
        label.textAlignment = .center
    }
    
}
