import UIKit

struct ExchangeRate {
    
    var currentUSD: Double
    var currentKRW: Double
    
    var currentRate: Double {
        willSet {
            print("currentRate willSet - 환율 변동 예정 \(currentRate) -> \(newValue)")
        }
        // 만약 이 값이 변경되면
        didSet {
            print("currentRate willSet - 환율 변동 \(oldValue) -> \(currentRate)")
            // 여기에서 해보고 결정
            currentUSD = KRW * currentRate
            currentKRW = USD / currentRate
        }
    }
    
    var USD: Double {
        // 만약 이 값이 변경되면 한국돈을 계산해서 바꾸기
        willSet {
            print("USD willSet - USD:\(newValue * currentRate)로 환전될 예정")
        }
        didSet {
            // 내 값은 이미 바뀌어져 있고, 상대의 값을 바꾸기
            currentKRW = USD * currentRate
            print("USD willSet - KRW:\(KRW) -> USD:\(USD * currentRate)로 환전되었음")
        }
    }
    
    var KRW: Double {
        willSet {
            print("KRW willSet - USD:\(newValue / currentRate)로 환전될 예정")
        }
        didSet {
            print("KRW willSet - KRW:\(KRW) -> USD:\(KRW / currentRate)로 환전되었음")
            currentUSD = KRW / currentRate
        }
    }
    
    // 새롭게 이니셜라이저를 만듬(단 이 경우에는 멤버와이즈 초기화 사용 불가
    init(currentRate: Double, USD: Double) {
        self.currentRate = currentRate
        self.USD = USD
        self.KRW = currentRate * USD
        self.currentUSD = USD
        self.currentKRW = KRW
    }
}

var rate = ExchangeRate(currentRate: 1100, USD: 1)
rate.KRW = 500000
rate.currentRate = 1350
rate.KRW = 500000
