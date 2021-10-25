//
//  DDayViewController.swift
//  AnniversaryCalculator
//
//  Created by 노건호 on 2021/10/07.
//

import UIKit

class DDayViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var after100Label: UILabel!
    @IBOutlet var after200Label: UILabel!
    @IBOutlet var after300Label: UILabel!
    @IBOutlet var after400Label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        after100Label.lineBreakMode = .byCharWrapping
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
        changeDateOf(after100Label, date: sender.date, afterDays: 100)
        changeDateOf(after200Label, date: sender.date, afterDays: 200)
        changeDateOf(after300Label, date: sender.date, afterDays: 300)
        changeDateOf(after400Label, date: sender.date, afterDays: 400)
        
    }
    
    func changeDateOf(_ label: UILabel, date: Date, afterDays: Int) {
//        DateFormatter 생성(날짜의 양식을 선택할 수 있음)
        // 원하는 국가의 날짜와, 시간을 표현할 수 있도록 하는 것
        // DateFormatter: 1. DateFormat 2. 원하는 국가
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        
        // 시간에 대한 타이밍을 계산할 수 있다(100일 뒤의 날짜)
        // 지금은 타임 인터벌을 사용할 예정이다.
        // 100일 뒤: TimeInterval
        let afterDate = Date(timeInterval: TimeInterval(86400 * afterDays), since: date)
        label.text = format.string(from: afterDate)
    }
}
