//
//  SnapDetailViewController.swift
//  SeSac_Week12
//
//  Created by 노건호 on 2021/12/14.
//

import UIKit
import SnapKit

class SnapDetailViewController: UIViewController {
    
    let activateButton: MainActivateButton = {
        let button = MainActivateButton()
        button.setTitle("다음", for: .normal)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
}
