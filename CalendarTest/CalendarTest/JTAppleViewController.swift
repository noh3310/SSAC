//
//  JTAppleViewController.swift
//  CalendarTest
//
//  Created by 노건호 on 2021/11/22.
//

import UIKit
import JTAppleCalendar

class JTAppleViewController: UIViewController {
    
    static let identifier = "JTAppleViewController"
    
    @IBOutlet weak var calendar: JTACMonthView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        calendar.delegate = self
//        calendar.dataSource = self
    }
}

extension JTAppleViewController: JTACMonthViewDataSource {
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = Date()
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
}


extension JTAppleViewController: JTACMonthViewDelegate {
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
//                let cell = cell as! DateCell
//                cell.dateLabel.text = cellState.text
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
//        cell.dateLabel.text = cellState.text
        cell.backgroundColor = .gray
        return cell
    }
}
