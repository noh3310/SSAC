//
//  ValidationViewController.swift
//  SeSACWeek15
//
//  Created by 노건호 on 2022/01/05.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ValidationViewModel {
    var validText = BehaviorRelay<String>(value: "최소 몇자 이상 필요하다.")
    
}

class ValidationViewController: UIViewController {
    
    let nameValidtionLabel = UILabel()
    let nameTextField = UITextField()
    let button = UIButton()
    
    let viewModel = ValidationViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        viewModel.validText
            .asDriver()
            .drive(nameValidtionLabel.rx.text)
//            .bind(to: nameValidtionLabel.rx.text)     // 위 두줄이랑 같은 코드, ui에서는 위에가 조금 더 적합함
            .disposed(by: disposeBag)
        
        let validation = nameTextField
            .rx.text
            .orEmpty
            .map { $0.count >= 5 }
            .share(replay: 1, scope: .whileConnected)   // 버퍼사이즈를 선택하는것
        
        validation
            .bind(to: button.rx.isEnabled)  // 버튼이 가능할지 연결
            .disposed(by: disposeBag)
        
        validation
            .bind(to: nameValidtionLabel.rx.isHidden)   // 숨길지 말지 설정
            .disposed(by: disposeBag)
        
        button
            .rx.tap
            .subscribe { _ in
                self.present(ReactiveViewController(), animated: true, completion: nil)
            }
    }
    
    func setup() {
        [nameTextField, button, nameValidtionLabel].forEach {
            $0.backgroundColor = .white
            view.addSubview($0)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(50)
        }
        
        nameValidtionLabel.snp.makeConstraints {
            $0.top.equalTo(200)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(50)
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(300)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(50)
        }
    }
}
