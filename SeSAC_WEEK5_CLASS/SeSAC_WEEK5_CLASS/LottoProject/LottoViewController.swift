//
//  LottoViewController.swift
//  SeSAC_WEEK5_CLASS
//
//  Created by 노건호 on 2021/10/25.
//

import UIKit

class LottoViewController: UIViewController {
    
    static let identifier = "LottoViewController"
    
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var winningNumberLabel: UILabel!
    
    @IBOutlet weak var winningNumberDateLabel: UILabel!
    
    @IBOutlet weak var numberInformationLabel: UILabel!
    
    @IBOutlet weak var winningNumberListLabel: UILabel!
    
    @IBOutlet weak var numberPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
