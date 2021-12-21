//
//  DummyViewController.swift
//  SeSAC_Week13
//
//  Created by 노건호 on 2021/12/21.
//

import UIKit
import SnapKit

class DummyViewController: UIViewController {
    
    let tableView = UITableView()
    
    let viewModel = DummyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
    }
    
    
}

extension DummyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightOfRowAt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier)
//
//        cell?.textLabel?.text = data[indexPath.row]
//
//        return cell!
        // 위 코드를 별도로 빼놨다. 이게 MVC인가
        return viewModel.cellForRowAt(tableView, indexPath: indexPath)
    }
}
