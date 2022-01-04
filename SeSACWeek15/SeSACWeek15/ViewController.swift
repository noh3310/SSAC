//
//  ViewController.swift
//  SeSACWeek15
//
//  Created by 노건호 on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    let label = UILabel()
    let disposeBag = DisposeBag()
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        viewModel.items
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(element) @ row \(row)"
                return cell
            }
            .disposed(by: disposeBag)
        
        // 레이블에 바인딩
        tableView.rx.modelSelected(String.self)
            .map({ data in
                "\(data) 를 클릭했습니다!!"
            })
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.navigationController?.pushViewController(Operator(), animated: true)
            self.present(Operator(), animated: true, completion: nil)
        }
    }
    
    func setup() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}

class ViewModel {
    
    let items = Observable.just([
        "First Item",
        "Second Item",
        "Third Item"
    ])
    
}
