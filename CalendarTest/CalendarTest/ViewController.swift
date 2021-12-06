//
//  ViewController.swift
//  CalendarTest
//
//  Created by 노건호 on 2021/11/19.
//

import UIKit
import FSCalendar

class ViewController: UIViewController {

    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bottomHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.dataSource = self
        calendar.delegate = self
        
        // 캘린더뷰 스와이프 설정
        setSwipeAction()
        
        // 캘린더 높이 설정
        calendarHeight.constant = self.view.bounds.height
        
        calendar.backgroundColor = .gray
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // 캘린더뷰 스와이프 이벤트 Action 연결
    func setSwipeAction() {
//        // 스와이프 등록(위로)
//        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
//        swipeUp.direction = .up
//        self.view.addGestureRecognizer(swipeUp)
//        
//        // 스와이프 등록(아래로)
//        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
//        swipeDown.direction = .down
//        self.view.addGestureRecognizer(swipeDown)
    }
    
//    // 스와이프 제스처를 했을 때 호출되는 Action
//    @objc func swipeEvent(_ swipe: UIGestureRecognizer) {
//        guard let swipeDirection = swipe as? UISwipeGestureRecognizer else { return }
//
//        // 위로 제스처 했을 때 캘린더 크기 수정
//        if swipeDirection.direction == .up {
//            print("위로 스와이프")
//            calendar.scope = .week
//        }
//        // 아래로 제스처 했을 때
//        else if swipeDirection.direction == .down {
//            print("아래로")
//            calendar.scope = .month
//        }
//    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        if calendar.scope == .week {
            calendar.scope = .month
        } else {
            calendar.scope = .week
        }
    }
}

extension ViewController: FSCalendarDelegate, FSCalendarDataSource {
    // 이벤트 개수(나중에 Realm이랑 연동해서 추가하면 될듯
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 1
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    }
    
    // 셀이 변경될 때 크기 어떻게 조절할것인지 설정
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
//        if calendar.scope == .week {
//            viewHeight.constant = 30
            calendarHeight.constant = bounds.height
//        } else {
//            viewHeight.constant = 0
//            calendarHeight.constant = self.view.bounds.height
//        }
//        self.view.setNeedsLayout()
//        UIView.animate(withDuration: 1) {
//            self.view.layoutIfNeeded()
//        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath)
        
//        cell.largeContentTitle = "\(indexPath.row)"
        
        return cell
    }
    
    
}
