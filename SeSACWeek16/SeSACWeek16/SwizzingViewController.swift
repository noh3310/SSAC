//
//  SwizzingViewController.swift
//  SeSACWeek16
//
//  Created by 노건호 on 2022/01/10.
//

import UIKit

class SwizzingViewController: UIViewController, URLSessionDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        "안녕".addingPercentEncoding(withAllowedCharacters: .url)
        print("www.naver.com/news?title=안녕".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)    // 아스키코드 외의 문자가 포함될 수 있음
        
        UIView() // => NSObject의 생성자가 있어서 비어있는 생성자를 생성할 수 있음
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear")
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        <#code#>
    }
}

//extension SwizzingViewController: URLSessionDelegate {
//
//    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
//        <#code#>
//    }
//
//    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//        <#code#>
//    }
//}

extension UIViewController {
    
    // 메서드 -> 런타임 실행 메서드
    // #selector: 런타임에서 어떻게할것인지 찾는다
    // @objc (Swift 4부터 사용된 개념)
    class func swizzleMethod() {
        let origin = #selector(viewWillAppear(_:))
        let change = #selector(changeViewWillAppear)
        
        guard let originMethod = class_getInstanceMethod(UIViewController.self, origin), let changeMethod = class_getInstanceMethod(UIViewController.self, change) else {
            print("함수를 찾을 수 없거나 오류")
            return
        }
        
        method_exchangeImplementations(originMethod, changeMethod)
    }
    
    @objc func changeViewWillAppear() {
        print(#function)
    }
}
