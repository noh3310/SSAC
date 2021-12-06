//
//  CalendarSwipeViewController.swift
//  CalendarTest
//
//  Created by 노건호 on 2021/11/21.
//

import UIKit
import FSCalendar

class CalendarSwipeViewController: UIViewController {
    
    static let identifier = "CalendarSwipeViewController"

    @IBOutlet weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        calendar.dataSource = self
        
        // 한달 단위(기본값)
        calendar.scope = .month
        // 일주일 단위
        calendar.scope = .week
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    // 스와이프 제스처를 했을 때 호출되는 Action
    @objc func swipeEvent(_ swipe: UISwipeGestureRecognizer) {
        
        // 위로 제스처 했을 때 캘린더 크기 수정
        if swipe.direction == .up {
            print("위로 스와이프")
            calendar.scope = .week
        }
        // 아래로 제스처 했을 때
        else if swipe.direction == .down {
            print("아래로")
            calendar.scope = .month
        }
    }
                                               
}

extension CalendarSwipeViewController: FSCalendarDelegate, FSCalendarDataSource {
    
}
