//
//  ReactiveViewController.swift
//  SeSACWeek15
//
//  Created by 노건호 on 2022/01/05.
//

import UIKit
import RxSwift
import SnapKit
import RxCocoa

struct SampleData {
    var user: String
    var age: Int
    var rate: Double
}

class ReactiveViewModel {
    
    var data = [
        SampleData(user: "Jack", age: 13, rate: 2.2),
        SampleData(user: "Hue", age: 11, rate: 4.4),
        SampleData(user: "Dustin", age: 12, rate: 3.3)
    ]
    
    var list = PublishRelay<[SampleData]>() // PublishRelay가 PublishSubject보다 조금 더 적합하다.(UI에서는 Relay가 조금 더 선호되나봄)
    
    func fetchData() {
//        list.onNext(data)   // list = data
        list.accept(data)
    }
    
    func filterData(_ query: String) {
        let result = query != "" ? data.filter { $0.user.contains(query) } : data
//        list.onNext(result) // 이벤트 교체
        list.accept(result)
    }
}

class ReactiveViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    let resetButton = UIButton()
    
    let viewModel = ReactiveViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        // viewModel data -> tableView ??
        viewModel.list
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(element) @ row \(row)"
                return cell
            }
            .disposed(by: disposeBag)

        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        resetButton.rx.tap
            .subscribe { _ in
                self.viewModel.fetchData()
            }
            .disposed(by: disposeBag)
        
        searchBar
            .rx.text    // 서치바에서 텍스트가 변경이 될 때 이벤트 발생
            .orEmpty    // 옵셔널 해제를 해줌
            .debounce(RxTimeInterval.microseconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged() // 같은 값일때는 구독을 하지 않는다.
            .subscribe { value in
                self.viewModel.filterData(value.element ?? "")
            }
            .disposed(by: disposeBag)
            
    }
    
    func setup() {
        navigationItem.titleView = searchBar
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        view.addSubview(resetButton)
        resetButton.backgroundColor = .systemRed
        resetButton.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func reactiveTest() {
        var apple = 1
        var banana = 2
        
        print(apple + banana)
        
        apple = 10
        banana = 20
        
        let a = BehaviorSubject(value: 1)
        let b = BehaviorSubject(value: 2)
        
        // 들어가있는 것 중 가장 마지막 값을 들어온다.
        Observable.combineLatest(a, b) { $0 + $1 }
        .subscribe {
            print($0.element ?? 0)
        }
        .disposed(by: disposeBag)
        
        a.onNext(50)
        b.onNext(10)
    }
}
