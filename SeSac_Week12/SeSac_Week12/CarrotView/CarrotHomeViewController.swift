//
//  CarrotHomeViewController.swift
//  SeSac_Week12
//
//  Created by 노건호 on 2021/12/15.
//

import UIKit

class CarrotHomeViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(view)
        }
        return tableView
    }()
    
    var dataSource = [CarrotItemTableViewCell]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        title = "홈"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CarrotItemTableViewCell.self, forCellReuseIdentifier: CarrotItemTableViewCell.identifier)
        
        dataSource.append(CarrotItemTableViewCell())
        dataSource.append(CarrotItemTableViewCell())
        tableView.reloadData()
    }
}

extension CarrotHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarrotItemTableViewCell.identifier, for: indexPath) as! CarrotItemTableViewCell
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
