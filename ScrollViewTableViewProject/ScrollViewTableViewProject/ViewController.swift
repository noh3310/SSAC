//
//  ViewController.swift
//  ScrollViewTableViewProject
//
//  Created by 노건호 on 2022/01/12.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "afasfsafsfasdfassfasfafasfsafsfasdfassfasfafasfsafsfasdfassfasfafasfsafsfasdfassfasfafasfsafsfasdfassfasfafasfsafsfasdfassfasfafasfsafsfasdfassfasfafasfsafsfasdfassfasfafasfsafsfasdfassfasfafasfsafsfasdfassfasfafasfsafsfasdfassfasfafasfsafsfasdfassfasfafasfsafsfasdfassfasfafasfsafsfasdfassfasfafasfsafsfasdfassfasf"
        label.numberOfLines = 0
        return label
    }()
    let scrollView = UIScrollView()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        label.backgroundColor = .red
        scrollView.backgroundColor = .blue
        tableView.backgroundColor = .green
        
//        label.text = "hello world"
        scrollView.addSubview(label)
        scrollView.addSubview(tableView)
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        label.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(tableView.snp.top)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.width.height.equalTo(view)
            make.height.equalTo(scrollView)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = .systemCyan
        
        return cell
    }
}

