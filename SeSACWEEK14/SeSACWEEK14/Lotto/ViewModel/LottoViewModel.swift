//
//  LottoViewModel.swift
//  SeSACWEEK14
//
//  Created by 노건호 on 2021/12/28.
//

import Foundation

class LottoViewModel {
    
    var lotto1 = Observable(3)
    var lotto2 = Observable(13)
    var lotto3 = Observable(33)
    var lotto4 = Observable(32)
    var lotto5 = Observable(31)
    var lotto6 = Observable(31)
    var lotto7 = Observable(30)

    var lottoMoney: Observable<String> = Observable("")
//    var lottoDate = Observable("")
    
    func fetchLottoAPI(_ number: Int) {
        APIService.lotto(number) { lotto, error in

            // 로또는 옵셔널 타입이기 때문에 해제할 수 있도록 한다.
            guard let lotto = lotto else {
                return
            }
            
            self.lotto1.value = lotto.drwtNo1
            self.lotto2.value = lotto.drwtNo2
            self.lotto3.value = lotto.drwtNo3
            self.lotto4.value = lotto.drwtNo4
            self.lotto5.value = lotto.drwtNo5
            self.lotto6.value = lotto.drwtNo6
            self.lotto7.value = lotto.bnusNo
            self.lottoMoney.value = self.format(for: lotto.firstWinamnt)   // 300,000,000
        }
    }
    
    func format(for number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(for: number)!
        return result
    }
}
