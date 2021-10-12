//
//  SettingTableViewController.swift
//  SeSAC_03Week
//
//  Created by 노건호 on 2021/10/12.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    // 전체 설정
    var settingArray = [["공지사항", "실험실", "버전 정보"],
                        ["개인/보안", "알림", "채팅", "멀티프로필"],
                        ["고객센터/도움말"]]
    var titleArray = ["전체설정", "개인 설정", "기타"]
    var list: [String] = ["장 보기", "메모메모", "영화 보러 가기", "WWDC"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // 섹션의 개수 리턴(기본은 1 리턴)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    // 섹션의 타이틀을 리턴함, 그런데 없어도 되기 때문에 리턴값이 옵셔널 타입임
    // titleForHeaderInSection
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // 타이틀을 리턴해줌
        return titleArray[section]
    }
    
    // (옵션) 셀 편집 상태: editingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // 삭제를 하면 어떻게 수행될지
        if editingStyle == .delete {
            settingArray[indexPath.section].remove(at: indexPath.row)

            tableView.reloadData()
        }
    }
    
    // (옵션) 셀의 편집 상태를 나타냄(스와이프 할지 안할지): canEditRowAt
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return indexPath.section == 0 ? false : true
        return true
    }
    
    // (옵션) 셀을 클릭했을 때 기능: didSelectRowAt
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section, ", ", indexPath.row)
    }
    
    /// 1, 2, 3 은 거의 필수 요건이다.
    // 1. 셀의 개수: numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return settingArray[section].count
    }
    
    // 2. 셀의 디자인 및 데이터 처리: cellForRowAt
    // 재사용 메커니즘, 옵셔널 체이닝
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(#function)
        
        // 어떤 셀을 사용할지 결정해서 cell 변수에 할당
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = settingArray[indexPath.section][indexPath.row]
        cell.textLabel?.textColor = .white
        
        return cell
    }
    
    // 3. (옵션)셀의 높이: heightForRowAt
    // indexPath를 주는 이유는 인덱스마다 높이가 다를 수 있기 때문(페이스북 처럼)
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return indexPath.section == 0 ? 40 : 80
//        return indexPath.row == 0 ? 40 : 80
        return 40
    }

}
