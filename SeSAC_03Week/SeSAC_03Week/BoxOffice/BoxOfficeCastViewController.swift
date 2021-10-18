//
//  BoxOfficeCastViewController.swift
//  SeSAC_03Week
//
//  Created by 노건호 on 2021/10/15.
//

import UIKit

class BoxOfficeCastViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var castTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 두개를 연결해주는 것을 코드로 설정해두면 된다.
        castTableView.delegate = self
        castTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    /// 아래 두개의 메서드는 다른 프로토콜과 다르게 override가 되어있지 않다. 오버라이드가 붙어져 있는 순간 UIMethod안에 있어야 하기 때문에 없다.
    // 섹션의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // row의 개수
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastCell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = "CAST \(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
