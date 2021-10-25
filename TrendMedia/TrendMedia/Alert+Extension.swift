//
//  Alert+Extension.swift
//  TrendMedia
//
//  Created by 노건호 on 2021/10/21.
//

import UIKit

extension UIViewController {
    func showAlert() {
        let alert = UIAlertController(title: "위치설정 해야해유", message: "하시겠어유?", preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "취소", style: .default) { _ in
            print("취소")
        }
        
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            print("확인")
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
}
