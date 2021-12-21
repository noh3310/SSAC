//
//  TableViewCellRepresentable.swift
//  SeSAC_Week13
//
//  Created by 노건호 on 2021/12/21.
//

import UIKit

protocol TableViewCellRepresentable {
    
    var numberOfSection: Int { get }
    var numberOfRowsInSection: Int { get }
    var heightOfRowAt: CGFloat { get }
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    
}
