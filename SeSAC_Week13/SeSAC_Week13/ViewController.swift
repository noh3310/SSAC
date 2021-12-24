//
//  ViewController.swift
//  SeSAC_Week13
//
//  Created by 노건호 on 2021/12/21.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    
    

    var tableView = UITableView()
    
    var apiService = APIService()
    
    var castData: Cast? // 배열 이어야 하는거 아닌가요?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        
        print(Thread.isMainThread)
        
        apiService.requestCast { cast in
            print(cast)
            self.castData = cast
            
            print(Thread.isMainThread)
            // Alamofire는 클로저구문에서 메인스레드로 바꿔주지만 Request는 별도의 스레드에서 동작하기때문에 메인스레드로 바꿔야한다.
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castData?.peopleListResult.peopleList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .value2, reuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = castData?.peopleListResult.peopleList[indexPath.row].peopleNm
        
        cell?.detailTextLabel?.text = "bbbb"
        
        return cell!
    }
}
