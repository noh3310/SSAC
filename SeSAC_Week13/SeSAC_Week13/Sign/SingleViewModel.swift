//
//  SingleViewModel.swift
//  SeSAC_Week13
//
//  Created by 노건호 on 2021/12/22.
//

import UIKit

class SingleViewModel {
    
    var navigationTitle: String = "내비게이션 타이틀"
    var buttonTItle: String = "가입하기"
    var textfieldPlaceHolder: String!
    
    fileprivate func didTapButton(completion: @escaping () -> Void) {
        completion()
    }
    
    var text: String = "고래밥" {
        didSet {
            let count = text.count
            let value = count >= 100 ? "작성할 수 없습니다." : "\(count)/100"
            let color: UIColor = count >= 100 ? .red : .black
            listener?(value, color)
        }
    }
    
    var listener: ((String, UIColor) -> Void)?
    
    func bind(listener: @escaping (String, UIColor) -> Void) {
        self.listener = listener
    }
}
