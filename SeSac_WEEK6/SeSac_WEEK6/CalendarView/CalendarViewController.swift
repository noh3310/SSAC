//
//  CalendarViewController.swift
//  SeSac_WEEK6
//
//  Created by 노건호 on 2021/11/01.
//

import UIKit
import FSCalendar
import RealmSwift

class CalendarViewController: UIViewController {

    static let identifier = "CalendarViewController"
    
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var allCountLabel: UILabel!
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserDiary>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 델리게이트 패턴
        // 프로토콜에서 제공하고 있는 필수 메서드를 써야한다.
        calendarView.delegate = self
        calendarView.dataSource = self
        
        // UserDiary 테이블에 있는 앱을 전체다 설정해줌
        tasks = localRealm.objects(UserDiary.self)
        
        print("relm: ", localRealm.configuration.fileURL!)
        
        let allCount = getAllDiaryCountFromUserDiary()
        allCountLabel.text = "총 \(allCount)개를 썼다."
        
        let recent = localRealm.objects(UserDiary.self).sorted(byKeyPath: "writeDate", ascending: false).first?.diaryTitle
        print("recent: ", recent)
        
        let photo = localRealm.objects(UserDiary.self).filter("content != nil").count
        print("photo: ", photo)
        
        let favorite = localRealm.objects(UserDiary.self).filter("favorite == false").count
        print("favorite: ", favorite)
        
        // String -> ' ', AND, OR 둘다 가능함
        // contains[c]는 안에 값이 있는지 확인함
        let search = localRealm.objects(UserDiary.self).filter("diaryTitle == '일기' AND content CONTAINS[c] '살아와'")
        print("search: ", search)
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    // 커스텀해서 달력을 바꾸고싶으면 하는것
//    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
//        let cell = FSCalendarCell()
//
//        return cell
//    }
    
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return "title"
//    }
//
//    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//        return "subTitle"
//    }
//
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        if #available(iOS 13.0, *) {
//            return UIImage(systemName: "star")
//        } else {
//            // Fallback on earlier versions
//        }
//        return UIImage()
//    }
    
    // 선택했을 때
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("date = \(date)")
        
        let contents = localRealm.objects(UserDiary.self).filter("writeDate == %@", date)
        print(contents)
    }
    
    
    // Date: 시분초까지 모두 동일해야함
    // 1. 영국 표준시 기준으로 표기: 2021-11-27 15:00:00 + 0000 -> 11/28
    // 2. 데이트 포맷터
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
//        let format = DateFormatter()
//        format.dateFormat = "yyyyMMdd"
//        let text = "20211103"
//
//        if format.date(from: text) == date {
//            return 3
//        } else {
//            return 1
//        }
        
        // 2. 11월 2일에 3개의 일기를 등록했다면 3개를 보여주면 될 것이다.
        // 아예 쓴 날이 없다면 1개만 쓰면 된다.
        // 작성한 날짜가 일치하는지 확인해본다.
        return tasks.filter("writeDate == %@", date).count
    }
}
