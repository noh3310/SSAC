//
//  ShoppingList.swift
//  SeSAC_03Week
//
//  Created by 노건호 on 2021/10/14.
//

import Foundation

// 그냥 True False 쓰면 되는데 공부 목적으로 추가함
enum isTrue: Int {
    case True
    case False
    
    var description: String {
        switch self {
        case .True:
            return "True"
        case .False:
            return "False"
        }
    }
}

struct ShoppingList {
    var isPurchased: isTrue
    var shoppingItem: String
    var isFavorite: isTrue
}
