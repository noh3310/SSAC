//
//  SettingViewController.swift
//  SeSAC_04_Week
//
//  Created by 노건호 on 2021/10/18.
//

import UIKit

// 과제에서 staticCell로 구현해서 과제가 있었다. 그 과제를 잘 해결했다면 쉽게 이해할 수 있을것이다.
// CaseIterable: 열거형을 배열처럼 접근할 수 있는 프로토콜, 생각보다 잘 사용이 된다.
enum SettingSection: Int, CaseIterable {
    case authorization
    case onlineShop
    case question
    
    var description: String {
        switch self {
        case .authorization:
            return "알림 설정"
        case .onlineShop:
            return "온라인 스토어"
        case .question:
            return "Q&A"
        }
    }
}

class SettingViewController: UIViewController {
    
    @IBOutlet weak var settingTableView: UITableView!
    
    let settingList = [["위치 알림 설정", "카메라 알림 설정"],
                       ["교보 문고", "영풍 문고", "반디앤루니스"],
                       ["앱스토어 리뷰 작성하기", "문의하기"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        
        // 테이블뷰에 nibName을 추가함
        // TableViewCell을 xib로 변환
        let nibName = UINib(nibName: DefaultTableViewCell.identifier, bundle: nil)
        settingTableView.register(nibName, forCellReuseIdentifier: DefaultTableViewCell.identifier)
    }

}

// 프로토콜은 아래 익스텐션을 사용해서 쓸 수 있다.
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingSection.allCases[section].description
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        // 콜렉션을 배열 크기로 가져옴
        return SettingSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.identifier, for: indexPath) as? DefaultTableViewCell else {
            return UITableViewCell()
        }
        
        cell.iconImageView.backgroundColor = .blue
        cell.titleLabel.text = settingList[indexPath.section][indexPath.row]
        
        return cell
    }
    
}

