//
//  LottoViewController.swift
//  SeSACWEEK14
//
//  Created by 노건호 on 2021/12/28.
//

import UIKit

// 우리가 만드는 뷰컨트롤러는 뷰에 해당이 된다고 보면 된다.
final class LottoViewController: UIViewController {
    
    let viewModel = LottoViewModel()
    
    // 1~7, 일자, 당첨 금액
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    let label4 = UILabel()
    let label5 = UILabel()
    let label6 = UILabel()
    let label7 = UILabel()
    
    let dateLabel = UILabel()
    let moneyLabel = UILabel()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.spacing = 8
        view.backgroundColor = .white
        view.distribution = .fillEqually
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // viewModel.lotto1 & label1.text
        
        // 뷰모델의 로또1을 바인드를 시켜준다.
        viewModel.lotto1.bind { number in
            self.label1.text = "\(number)"
        }
        
        viewModel.lotto2.bind { number in
            self.label2.text = "\(number)"
        }
        
        viewModel.lotto3.bind { number in
            self.label3.text = "\(number)"
        }
        
        viewModel.lotto4.bind { number in
            self.label4.text = "\(number)"
        }
        
        viewModel.lotto5.bind { number in
            self.label5.text = "\(number)"
        }
        
        viewModel.lotto6.bind { number in
            self.label6.text = "\(number)"
        }
        
        viewModel.lotto7.bind { number in
            self.label7.text = "\(number)"
        }
        
        viewModel.lottoMoney.bind { money in
            self.moneyLabel.text = money
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.fetchLottoAPI(678)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            self.viewModel.fetchLottoAPI(777)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.height.equalTo(50)
            $0.center.equalTo(view)
        }
        
        [label1, label2, label3, label4, label5, label6, label7].forEach { $0.backgroundColor = .lightGray
            stackView.addArrangedSubview($0)
        }
        
        view.addSubview(dateLabel)
        dateLabel.backgroundColor = .white
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(20)
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.height.equalTo(50)
        }
        
        view.addSubview(moneyLabel)
        moneyLabel.backgroundColor = .white
        moneyLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.height.equalTo(50)
        }
    }
}
