//
//  PickerViewController.swift
//  SeSACWeek15
//
//  Created by 노건호 on 2022/01/03.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class PickerViewController: UIViewController {
    
    let pickerView = UIPickerView()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = Observable.just([
            "First Item",
            "Second Item",
            "Third Item"
        ])
        
        items
            .bind(to: pickerView.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        setup()
        
        view.backgroundColor = .white
        
        // Observable 설정(타입을 일치)
        // .subscribe를 통해서 옵저버를 생성
        pickerView.rx.modelSelected(String.self)
            .subscribe { value in
                print(value)
            }
            .disposed(by: disposeBag)
        
    }
    
    func setup() {
        view.addSubview(pickerView)
        pickerView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
    }
    
}
