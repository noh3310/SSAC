//
//  Observable.swift
//  SeSACWEEK14
//
//  Created by 노건호 on 2021/12/27.
//

import Foundation

class Observable<T> {
    // 옵셔널로 init 만들어줌
    private var listener: ( (T) -> Void )?
    
    // listener에 value를 전해줌
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
