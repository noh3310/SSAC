//
//  TempViewController.swift
//  AccessLevelsProject
//
//  Created by 노건호 on 2021/12/24.
//

import UIKit

class TempViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - tableView: <#tableView description#>
    ///   - indexPath: <#indexPath description#>
    /// - Returns: <#description#>
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        print(#function)
        
        _ = "sttoryboard"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print(#function)
    }
    
    /// - parameters message: 메시지
    /// - important hello
    ///  - returns: 닉네임 전달
    ///  - ㅁㄴㄹㅁㄴㄹㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㄴㅇㄹ
    ///     - 닉네임 최소 3개, **숫자 불가**
    ///     - 나이: 한국 나이 사이트 링크 [바로가기]()
    func welcome(message: String, completion: @escaping () -> Void) -> String {
        
    }
}

class User: Equatable {
    
    var name: String
    var age: Int
    var email: String
    var review: Double
    
    internal init(name: String, age: Int, email: String, review: Double) {
        self.name = name
        self.age = age
        self.email = email
        self.review = review
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name &&
        lhs.age == rhs.age &&
        lhs.email == rhs.email &&
        lhs.review == rhs.review
    }
}

// MARK: 이게 뭘까요
