//
//  ButtonViewController.swift
//  SeSACWeek15
//
//  Created by 노건호 on 2022/01/06.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import SwiftUI

// zip. merge, flatMapLatest >
class ButtonViewModel: CommonViewModel {
    
    struct Input {
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let text: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let result = input.tap
            .map { "안녕 반가워" }
            .asDriver(onErrorJustReturn: "")
        
        return Output(text: result)
    }
}

class ButtonViewController: UIViewController {
    
    let viewModel = ButtonViewModel()
    
    let button: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    let label = UILabel()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        // 버튼을 클릭하면 레이블에 내용이 출력되도록 하는 것
        // 버튼 탭 -> 안녕 반가워! -> 레이블 =>
        
        
        bind()
    }
    
    func bind() {
        let input = ButtonViewModel.Input(tap: button.rx.tap)
        
        let output = viewModel.transform(input: input)
        output.text
            .drive(self.label.rx.text)
            .disposed(by: disposeBag)
    }
    
    func setup() {
        view.addSubview(button)
        view.addSubview(label)
        button.backgroundColor = .white
        label.backgroundColor = .white
        
        button.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.center.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(100)
            $0.leading.equalTo(20)
            $0.width.equalTo(300)
            $0.height.equalTo(50)
        }
    }
    
    func buttonTap() {
        // 버튼 탭에서 처리해주는 영역(단순 UI변경에는 아래 방법이 가장 맞는 방법)
        // 하지만 다르게 하는 방법도 있다.
//        button.rx.tap
//            .map { "안녕 반가워" }
//            .asDriver(onErrorJustReturn: "")
//            .drive(label.rx.text)
//            .disposed(by: disposeBag)

        //        button.rx.tap
        //            .observe(on: MainScheduler.instance)
        //            .subscribe { _ in   // subscribe의 경우에는 네트워크통신으로 들어갔을 때 백그라운드 스레드로 처리된다. 그래서 메인스레드로 변경해야한다.
        ////                self.label.text = "안녕"
        //                print(self.label.text!)
        //            }
        //            .disposed(by: disposeBag)
        //
        //        button.rx.tap
        //            .bind { _ in    // bind를 쓰면 메인 스레드에서 되기 때문에 별도로 스레드를 변경하지 않아도 된다.
        //                print(self.label.text!)
        //            }
        //            .disposed(by: disposeBag)
        
        //        button.rx.tap
        //            .map { "안녕 반가워" }
        //            .bind(to: label.rx.text)
        //            .disposed(by: disposeBag)
    }
}
