//
//  GradeCalculator.swift
//  SeSACWeek15
//
//  Created by 노건호 on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class GradeCalculator: UIViewController {
    
    let mySwitch = UISwitch()
    
    let first = UITextField()
    let second = UITextField()
    let resultLabel = UILabel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        // 바인딩을 해줌
        // mySwitch.rx.isOn은 Rx에서 현재 상태를 스위치해주는 부분이다.
        Observable.of(true)
            .bind(to: mySwitch.rx.isOn)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(first.rx.text.orEmpty, second.rx.text.orEmpty) { textValue1, textValue2 -> Double in
            return ((Double(textValue1) ?? 0.0) + (Double(textValue2) ?? 0.0)) / 2
        }
        .map { "\($0)" }
        .bind(to: resultLabel.rx.text)
        .disposed(by: disposeBag)
    }
    
    func setup() {
        view.addSubview(mySwitch)
        mySwitch.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        view.addSubview(first)
        view.addSubview(second)
        view.addSubview(resultLabel)
        first.backgroundColor = .white
        second.backgroundColor = .white
        resultLabel.backgroundColor = .white
        
        first.snp.makeConstraints {
            $0.top.equalTo(100)
            $0.size.equalTo(50)
            $0.leading.equalTo(50)
        }
        
        second.snp.makeConstraints {
            $0.top.equalTo(100)
            $0.size.equalTo(50)
            $0.leading.equalTo(120)
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(100)
            $0.size.equalTo(50)
            $0.leading.equalTo(200)
        }
    }
}
