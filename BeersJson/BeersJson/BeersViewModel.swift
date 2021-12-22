//
//  BeersViewModel.swift
//  BeersJson
//
//  Created by 노건호 on 2021/12/22.
//

import Foundation

class BeersViewModel {
    
    static var beers: [Beer] {
        // Json파일 위치 받아옴
        print("1")
        let path = Bundle.main.path(forResource: "beers", ofType: "json")
        print("2")
        print(path)
        var result = [Beer]()
    
        do {
            // URL에서 데이터 직접 초기화하기
            print("3")
            let data = try Data(contentsOf: URL(fileURLWithPath: path!) )
            print("4")
            // 디코딩
            result = try JSONDecoder().decode([Beer].self, from: data)
            print(result)
        } catch {
            print(error)
        }
        
        return result
    }

//    func decodingData() -> [Beer] {
//        // Json파일 위치 받아옴
//        let path = Bundle.main.path(forResource: "beers", ofType: "json")!
//        var result = [Beer]()
//    
//        do {
//            // URL에서 데이터 직접 초기화하기
//            let data = try Data(contentsOf: URL(string: path)!)
//            
//            // 디코딩
//            result = try JSONDecoder().decode([Beer].self, from: data)
//            
//        } catch {
//            print(error)
//        }
//        
//        return result
//    }
    
}
