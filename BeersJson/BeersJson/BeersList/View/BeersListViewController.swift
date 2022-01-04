//
//  BeersListViewController.swift
//  BeersJson
//
//  Created by 노건호 on 2021/12/20.
//

import UIKit
import SnapKit

class BeersListViewControllers: UIViewController {
    
    let tableView = UITableView()
    
    let viewModel = BeersViewModel.beers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BeersTableViewCell.self, forCellReuseIdentifier: BeersTableViewCell.identifier)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
}

extension BeersListViewControllers: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BeersTableViewCell.identifier, for: indexPath) as! BeersTableViewCell
        
        cell.setCell(viewModel[indexPath.row])
        
        return cell
    }
    
    // 셀 클릭했을 떄
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BeerInformationViewController()
        
        vc.beerInformation = viewModel[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}