//
//  MemoTableViewController.swift
//  SeSAC_03Week
//
//  Created by 노건호 on 2021/10/12.
//

import UIKit

class MemoTableViewController: UITableViewController {
    
    // 메모와 userdefaults를 다뤄보고 싶었는데 내용을 나눠서 진행해보려고 한다.
    // 테이블뷰 컨트롤러를 커스텀셀을 학습했으니 이정도까지 하면 될 것이다.
    var list: [String] = ["장 보기", "메모메모", "영화 보러 가기", "WWDC"] {
        // 완벽하게 배열이 변경이 되고 나서 테이블뷰를 reload함
        didSet {
            tableView.reloadData()
        }
    }
        
    @IBOutlet weak var memoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func saveButtonClicked(_ sender: UIButton) {
        // 배열에 텍스트뷰의 텍스트 값 추가
        // 옵셔널 바인딩
        if let text = memoTextView.text {
            list.append(text)
            
//            tableView.reloadData()
            
            print(list)
        }
        else {
            print(".none")
        }
//        let text = memoTextView.text
        
    }
    
    // 섹션의 개수 리턴(기본은 1 리턴)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // 섹션의 타이틀을 리턴함, 그런데 없어도 되기 때문에 리턴값이 옵셔널 타입임
    // titleForHeaderInSection
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "섹션 타이틀"
    }
    
    // (옵션) 셀 편집 상태: editingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        // 삭제를 하면 어떻게 수행될지
        if editingStyle == .delete && indexPath.section == 1 {
            list.remove(at: indexPath.row)
            // tableView.reloadData()
        }
    }
    
    // (옵션) 셀의 편집 상태를 나타냄(스와이프 할지 안할지): canEditRowAt
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 ? false : true
    }
    
    // (옵션) 셀을 클릭했을 때 기능: didSelectRowAt
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section, ", ", indexPath.row)
    }
    
    /// 1, 2, 3 은 거의 필수 요건이다.
    // 1. 셀의 개수: numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 { return 2 }
//        else { return 4 }
        
        return section == 0 ? 2 : list.count
    }
    
    // 2. 셀의 디자인 및 데이터 처리: cellForRowAt
    // 재사용 메커니즘, 옵셔널 체이닝
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(#function)
        
        // 어떤 셀을 사용할지 결정해서 cell 변수에 할당
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell") else {
            return UITableViewCell()
        }
        
//        // 이 과정은 아래 코딩을 통해서 대체할 수 있음
//        // cell?.textLabel?.text = "ssss"
//        if cell != nil {
//            if cell!.textLabel != nil {
//                cell!.textLabel!.text = "ssss"
//            }
//        }
        
        
        if indexPath.section == 0 {
            // cell 속성 설정
            cell.textLabel?.text = "첫번째 섹션 - \(indexPath)"
            cell.textLabel?.textColor = .brown
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
        }
        else {
            cell.textLabel?.text = list[indexPath.row]
            cell.textLabel?.textColor = .blue
            cell.textLabel?.font = .boldSystemFont(ofSize: 13)
        }
        
        return cell
    }
    
    // 3. (옵션)셀의 높이: heightForRowAt
    // indexPath를 주는 이유는 인덱스마다 높이가 다를 수 있기 때문(페이스북 처럼)
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return indexPath.section == 0 ? 40 : 80
        return indexPath.row == 0 ? 40 : 80
    }
}
