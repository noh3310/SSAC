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
        
        cell.itemImageView.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
            // 1:1 비율로 이미지 설정
            make.width.equalTo(cell.itemImageView.snp.height).multipliedBy(1.0 / 1.0)
        }
        
        cell.itemTitle.text = "뭘"
        cell.itemTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(cell.itemImageView.snp.right).offset(20)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
