//
//  SquareBoxView.swift
//  SeSac_Week12
//
//  Created by 노건호 on 2021/12/13.
//

import UIKit

class SquareBoxView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadView()
        
        loadUI()
    }
    
    func loadView() {
        // 컴퓨터가 이해할 수 있도록 nib으로 변환해야함
        // bundle이 nil이라면 메인 번들로 인식한다.
        // instantiate에서 SquareBoxView에 있는 전체 View를 다 가져오고, 그중에 처음것을 가져오고 타입캐스팅 수행
        let view = UINib(nibName: "SquareBoxView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        
        // 이런식으로도 선언이 가능(무슨차이인지는 확인해봐야할듯)
        // 위 방법을 많이 사용한다고 한다.
//        let view2 = Bundle.main.loadNibNamed("SquareBoxView", owner: nil, options: nil)?.first as! UIView
        
        view.frame = bounds
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        // 가져온 뷰를 추가해준 것
        self.addSubview(view)
    }
    
    func loadUI() {
        label.font = .boldSystemFont(ofSize: 13)
        label.textAlignment = .center
        label.text = "마이페이지"
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .black
    }
}
