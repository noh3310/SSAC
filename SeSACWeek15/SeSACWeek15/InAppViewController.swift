//
//  InAppViewController.swift
//  SeSACWeek15
//
//  Created by 노건호 on 2022/01/07.
//

import UIKit
import StoreKit
import SnapKit

class InAppViewController: UIViewController {
    
    // com.memolease.cookie1
    // 1. 인앱 상품 ID정의
    var productionIdentifiers: Set<String> = ["game.GOLD"]
    
    let button = UIButton()
    
    // 3 - 1. 인앱 상품 배열
    var productArray = Array<SKProduct>()
    var product: SKProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestProductData()
        
        view.addSubview(button)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        button.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(100)
        }
    }
    
    // 4. 구매 버튼 클릭
    @objc func buttonClicked() {
        let payment = SKPayment(product: product!)
        
        // 상품 추가
        SKPaymentQueue.default().add(payment)
//        SKPaymentQueue.default().
    }
    
    // 2. productIdentifiers에 덩의된 상품 ID에 대한 정보 가져오기 및 사용자의 디바이스가 인앱결제가 가능한지 여부 확인
    func requestProductData() {
        // 구매가 가능한지 안한지 확인하는 것
        if SKPaymentQueue.canMakePayments() {
            print("인앱 결제 가능")
            // 문자열에 요쳥한다.
            let request = SKProductsRequest(productIdentifiers: productionIdentifiers)
            request.delegate = self
            request.start()
        } else {
            print("인앱 결제 불가능")
        }
    }
    
    func receiptValidation(transaction: SKPaymentTransaction, productIdentifier: String) {
        
        // 구매 영수증 정보
        let receiptFileURL = Bundle.main.appStoreReceiptURL
        let receiptData = try? Data(contentsOf: receiptFileURL!)
        let receiptString = receiptData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        print(receiptString)
        // 거래 내역(transaction)을 큐에서 제거
        SKPaymentQueue.default().finishTransaction(transaction)
    }
}

extension InAppViewController: SKProductsRequestDelegate {
    // 3. 인앱 상품의 정보를 조회해서 결과를 받는 메서드
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        // 배열로 상품을 본다
        let products = response.products
        
        if products.count > 0 {
            
            for i in products {
                productArray.append(i)
                product = i // 옵션
                
                print("product: ", i)
                print(i.localizedTitle, i.price, i.priceLocale, i.localizedDescription)
            }
            
        } else {
            print("No Product Found")
        }
    }
}

// SKPaymentTransactionObserver: 구매 취소, 승인 등에 대한 프로토콜, 업데이트 된 거래 내역 받아보기
extension InAppViewController: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("updatedTransactions")
        
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:  // 구매 승인 이후에 영수증 검증
                print("Transaction Approved. \(transaction.payment.productIdentifier)")
                receiptValidation(transaction: transaction, productIdentifier: transaction.payment.productIdentifier)
            case .failed:  // 실패 토스트, transaction
                print("Transaction Failed")
                SKPaymentQueue.default().finishTransaction(transaction)
            @unknown default:
                break
            }
        }
    }
    
    // 트랜잭션이 취소될 때
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        print("removedTransactions")
    }
}
