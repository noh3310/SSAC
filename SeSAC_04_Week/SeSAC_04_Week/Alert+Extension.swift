//
//  Alert+Extension.swift
//  SeSAC_04_Week
//
//  Created by 노건호 on 2021/10/21.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, okTitle: String, okAction: @escaping () -> ()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // 아래코드에서 handler는 옵셔널 타입이기 때문에 handler는 없애줘도 됨
        // let cancel = UIAlertAction(title: "cnrk", style: .default, handler: nil)
        let cancel = UIAlertAction(title: "취소", style: .default)
        
        let ok = UIAlertAction(title: okTitle, style: .default) { _ in
            print("확인 버튼 눌렀음")
            
            // okAction이 밖에서도 사용할 수 있도록 "탈출 클로저"로 설정을 해줘야 한다.
            okAction()
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        // completion은 alert가 뜬 후에 어떻게 될 것인지 설정하는 부분
        self.present(alert, animated: true) {
            print("얼럿이 떴다.")
        }
    }
    
}
