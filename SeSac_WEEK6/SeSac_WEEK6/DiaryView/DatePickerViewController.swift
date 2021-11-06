//
//  DatePickerViewController.swift
//  SeSac_WEEK6
//
//  Created by 노건호 on 2021/11/05.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    static let identifier = "DatePickerViewController"

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        if #available(iOS 13.4, *) {
//            datePicker.preferredDatePickerStyle = .wheels
//        } else {
//            // Fallback on earlier versions
//        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
