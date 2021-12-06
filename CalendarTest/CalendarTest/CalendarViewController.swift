//
//  CalendarViewController.swift
//  CalendarTest
//
//  Created by 노건호 on 2021/11/20.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    
    static let identifier = "CalendarViewController"
    
    var height: CGFloat = 50

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        print(#function)
//        print("aasdfasfas")
//        print(self.view.safeAreaLayoutGuide.layoutFrame.height)
//        print(self.view.safeAreaLayoutGuide.layoutFrame.width)
//
//        height = self.view.safeAreaLayoutGuide.layoutFrame.height
//
//        print("asdfsafsdf")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        // 캘린더뷰 스와이프 이벤트 액션 연결
        setSwipeAction()
        
        calendar.delegate = self
        calendar.dataSource = self
        
        calendarHeight.constant = self.view.bounds.height
        
        calendar.backgroundColor = .gray
        
//        calendar.weekdayHeight = -20
//        calendar.headerHeight = -6.0
        
        
        
//        let scopeGesture = UIPanGestureRecognizer(target: calendar, action: #selector(calendar.handleScopeGesture(_:)));
//        calendar.addGestureRecognizer(scopeGesture)
        
//        calendarHeight.constant = self.view.bounds.height

        
        calendar.scope = .week
        
        

//         calendarHeight.constant = self.view.safeAreaLayoutGuide.layoutFrame.height
        
        
//        tableView.delegate = self
//        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        print(calendar.weekdayHeight)
//        safeAreaLayoutGuide.layoutFrame.height
//        print(calendarHeight.constant)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
        
//        calendarHeight.constant = self.view.safeAreaLayoutGuide.layoutFrame.height
        
        height = self.view.safeAreaLayoutGuide.layoutFrame.height
       
        print(calendar.weekdayHeight)
    }
    
    // 캘린더뷰 스와이프 이벤트 Action 연결
    func setSwipeAction() {
        // 스와이프 등록(위로)
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        // 스와이프 등록(아래로)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    // 스와이프 제스처를 했을 때 호출되는 Action
    @objc func swipeEvent(_ swipe: UISwipeGestureRecognizer) {
        // 위로 제스처 했을 때 캘린더 크기 수정
        if swipe.direction == .up {
            print("위로 스와이프")
//            calendar.scope = .week
            calendar.setScope(.week, animated: true)
        }
        // 아래로 제스처 했을 때
        else if swipe.direction == .down {
            print("아래로")
//            calendar.scope = .month
            calendar.setScope(.month, animated: true)
        }
    }
    
    
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 50
    }
    
//    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
//        let cell = calendar.dequeueReusableCell(withIdentifier: "CELL", for: date, at: position)
//        cell.imageView.backgroundColor = UIColor.red
//        return cell
//    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        
      if calendar.scope == .week {
          print("calendar.headerHeight", calendar.headerHeight)
//          calendar.rowHeight -= 10
//
//          calendar.headerHeight -= 5
          print("calendar.headerHeight", calendar.headerHeight)
          calendarHeight.constant = bounds.height
      }
      else if calendar.scope == .month {
//          calendar.rowHeight += 10
////          calendar.weekdayHeight += 25
//          calendar.headerHeight += 5
          calendarHeight.constant = self.view.bounds.height

      }
        
//    calendarHeight.constant = bounds.height
//        
      UIView.animate(withDuration: 0.5) {
          self.view.layoutIfNeeded()
      }
//        if calendar.scope == .week {
//            print("calendar.headerHeight", calendar.headerHeight)
//            print("calendar.weekdayHeight", calendar.weekdayHeight)
//            print("calendar.rowHeight", calendar.rowHeight)
//            print("bounds", bounds.height)
//
//
//            calendar.weekdayHeight = -10
//            calendar.rowHeight -= 30
//            calendarHeight.constant = bounds.height
////            abs(calendar.headerHeight) + abs(calendar.weekdayHeight) + abs(calendar.rowHeight)
//
//            print("calendar.headerHeight", calendar.headerHeight)
//            print("calendar.weekdayHeight", calendar.weekdayHeight)
//            print("calendar.rowHeight", calendar.rowHeight)
////            calendar.rowHeight = 20
//
////            calendar.headerHeight = 20
////            calendar.
//        }
//        else if calendar.scope == .month {
////            calendar.weekdayHeight = calendar.weekdayHeight
//            calendar.weekdayHeight += 10
//            calendar.rowHeight += 30
//
//            calendarHeight.constant = height
//        }
//        print(calendarHeight.constant)
//        UIView.animate(withDuration: 0.5) {
//            self.view.layoutIfNeeded()
//        }
        
    }
}

//extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 100
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath)
//
//
//
//        return cell
//    }
//
//
//
//
//}
