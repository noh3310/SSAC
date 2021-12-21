//
//  DummyData.swift
//  SeSAC_Week13
//
//  Created by 노건호 on 2021/12/21.
//

import UIKit

class DummyViewModel {
    let data: [String] = Array(repeating: "테스트", count: 100)
}

extension DummyViewModel: TableViewCellRepresentable {
    var numberOfSection: Int {
        return 1
    }
    
    var numberOfRowsInSection: Int {
        return data.count
    }
    
    var heightOfRowAt: CGFloat {
        return 80
    }
    
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier)
        
        cell?.textLabel?.text = data[indexPath.row]
        
        return cell!
    }
}
