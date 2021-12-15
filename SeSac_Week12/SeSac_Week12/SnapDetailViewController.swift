//
//  SnapDetailViewController.swift
//  SeSac_Week12
//
//  Created by 노건호 on 2021/12/14.
//

import UIKit
import SnapKit

class SnapDetailViewController: UIViewController {
    
    let firstSquareView: SquareBoxView = {
        let view = SquareBoxView()
        
        view.label.text = "토스뱅크"
        view.imageView.image = UIImage(systemName: "trash.fill")
        
        return view
    }()
    
    let secondSquareView: SquareBoxView = {
        let view = SquareBoxView()
        
        view.label.text = "토스증권"
        view.imageView.image = UIImage(systemName: "chart.xyaxis.line")
        
        return view
    }()
    
    let thirdSquareView: SquareBoxView = {
        let view = SquareBoxView()
        
        view.label.text = "고객센터"
        view.imageView.image = UIImage(systemName: "person")
        
        return view
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        // 수평으로 정렬
        stack.axis = .horizontal
        // 스택뷰사이의 간격 설정
        stack.spacing = 12
        // 스택뷰의 Alignment(꽉 차게 구성)
        stack.alignment = .fill
        // destribution 똑같이 나눠주겠다
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    let activateButton: MainActivateButton = {
        let button = MainActivateButton()
        button.setTitle("다음", for: .normal)
        button.addTarget(self, action: #selector(activateButtonClicked), for: .touchUpInside)
        return button
    }()
    
    let activateButton2: MainActivateButton = {
        let button = MainActivateButton()
        button.setTitle("다음", for: .normal)
        button.addTarget(self, action: #selector(activateButton2Clicked), for: .touchUpInside)
        return button
    }()
    
    // 아래와 같이 표현해도 문제는 없음
    // 익명함수라는 개념
    // 이거는 취향에 따라서 하면 될것임
    let moneyLabel: UILabel = {
        let label = UILabel()
        
        label.backgroundColor = .yellow
        label.text = "12,333원"
        
        return label
    }()
    
    let descriptionLabel = UILabel()
    
    let redView = UIView()
    let blueView = UIView()
    
    @objc func activateButtonClicked() {
        let vc = SettingViewController(nibName: "SettingViewController", bundle: nil)
        
        vc.name = "김선달"
//        let vc = DetailViewController()
        present(vc, animated: true, completion: nil)
    }
    
    @objc func activateButton2Clicked() {
        let vc = SettingViewController(nibName: "SettingViewController", bundle: nil)
        
        vc.name = "김선달"
//        let vc = DetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // StackView
        view.addSubview(stackView)
        stackView.addArrangedSubview(firstSquareView)
        stackView.addArrangedSubview(secondSquareView)
        stackView.addArrangedSubview(thirdSquareView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalTo(view)
            $0.width.equalTo(view.snp.width).multipliedBy(0.9)
            $0.height.equalTo(80)
        }
        
        view.backgroundColor = .white
        
        [activateButton, moneyLabel, descriptionLabel, redView].forEach {
            view.addSubview($0)
        }
        
        moneyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.width.equalTo(300)
            make.height.equalTo(80)
        }
        
        activateButton.snp.makeConstraints {
            $0.leadingMargin.equalTo(view)
            $0.trailingMargin.equalTo(view)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(view).multipliedBy(0.1)
        }
        
        
        
        
//        activateButton2.snp.makeConstraints {
//            $0.width.equalTo(activateButton)
//            $0.centerX.equalTo(activateButton)
////            $0.leadingMargin.equalTo(view)
////            $0.trailingMargin.equalTo(view)
//            $0.bottom.equalTo(activateButton.snp.top).offset(20)
//            $0.height.equalTo(view).multipliedBy(0.1)
//        }
        
        redView.backgroundColor = .systemRed
        redView.snp.makeConstraints { make in
//            make.top.equalTo(view)
//            make.leading.equalTo(view)
//            make.trailing.equalTo(view)
//            make.bottom.equalTo(view)
            // 두가지 방법으로 네방향을 같이 만들 수 있다.
            make.edges.equalToSuperview().inset(100)
//            make.edges.equalTo(view)
            
        }
        
        // 키보드와같은 것이 나타날 때 이걸 사용하면 됨
        redView.snp.updateConstraints { make in
            
            make.bottom.equalTo(-500)
        }
        
        redView.addSubview(blueView)
        blueView.backgroundColor = .systemBlue
        blueView.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(50)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firstSquareView.alpha = 0
        secondSquareView.alpha = 0
        thirdSquareView.alpha = 0
        UIView.animate(withDuration: 0.2) {
            self.firstSquareView.alpha = 1
//            self.secondSquareView.alpha = 1
//            self.thirdSquareView.alpha = 1
        } completion: { bool in
            UIView.animate(withDuration: 0.2) {
                self.secondSquareView.alpha = 1
            } completion: { bool in
                UIView.animate(withDuration: 0.2) {
                    self.thirdSquareView.alpha = 1
                }
            }
        }
    }
    
}
