//
//  TwoViewController.swift
//  EmotionDiary
//
//  Created by 노건호 on 2021/10/05.
//

import UIKit

class TwoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print(self, #function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(self, #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(self, #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print(self, #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print(self, #function)
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
