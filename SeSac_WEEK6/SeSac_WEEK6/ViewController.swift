//
//  ViewController.swift
//  SeSac_WEEK6
//
//  Created by 노건호 on 2021/11/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var backupRestoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for family in UIFont.familyNames {
            print(family)
            
            for sub in UIFont.fontNames(forFamilyName: family) {
                print("====> \(sub)")
            }
        }
        
//        S-Core Dream
//        ====> S-CoreDream-2ExtraLight
//        ====> S-CoreDream-5Medium
//        ====> S-CoreDream-9Black
        
        welcomeLabel.text = LocalizableString.welcome_text.localized
        // 11~20을 많이 사용함
        welcomeLabel.font = UIFont().mainBlack
        
        backupRestoreLabel.text = LocalizableString.data_backup.localizedWithTable
        
    }


}

