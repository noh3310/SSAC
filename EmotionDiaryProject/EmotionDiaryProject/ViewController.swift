//
//  ViewController.swift
//  EmotionDiaryProject
//
//  Created by 노건호 on 2021/10/06.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    var buttonList: [UIButton] = []
    var stackView: UIStackView!
    var stackView1: UIStackView!
    var stackView2: UIStackView!
    var stackView3: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        for _ in 0..<9 {
            setButton()
        }
        
        var btList = [buttonList[0], buttonList[1], buttonList[2]]
        stackView1 = setStackViewOf(btList, axis: Axis.horizontal)
        btList = [buttonList[3], buttonList[4], buttonList[5]]
        stackView2 = setStackViewOf(btList, axis: Axis.horizontal)
        btList = [buttonList[6], buttonList[7], buttonList[8]]
        stackView3 = setStackViewOf(btList, axis: Axis.horizontal)
        
        stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        stackView.addSubview(stackView1)
//        stackView.addArrangedSubview(stackView2)
//        stackView.addArrangedSubview(stackView3)
        

    }
    
    func setButton() {
        let btn = UIButton()
        
//        self.view.addSubview(btn)
        
        btn.translatesAutoresizingMaskIntoConstraints = false

//        btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        btn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 300).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 20).isActive = true

        btn.setTitle("버튼", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .orange
        
        buttonList.append(btn)
    }
    
    func setStackViewOf(_ buttonList: [UIButton], axis: Axis) -> UIStackView {
        let sView = UIStackView()
        
        sView.axis = (axis == Axis.vertical) ? .vertical : .horizontal
        sView.alignment = .fill
        sView.distribution = .fill
        sView.spacing = 10
        sView.translatesAutoresizingMaskIntoConstraints = false
        
//        self.view.addSubview(sView)
        
//        sView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
//        sView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//        self.view.bottomAnchor.constraint(equalTo: sView.bottomAnchor).isActive = true
//        self.view.trailingAnchor.constraint(equalTo: sView.trailingAnchor).isActive = true
        
//        sView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        sView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        for index in buttonList.indices {
            sView.addArrangedSubview(buttonList[index])
        }

        return sView
    }
    
    

}


//// TermsViewControllerPreviews.swift
//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//
//struct preview_device: PreviewProvider {
//
//    @available(iOS 13.0, *)
//    static var previews: some View {
//        preview_device()
//    }
//
//}
//#endif

