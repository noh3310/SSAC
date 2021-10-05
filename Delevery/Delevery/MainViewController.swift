//
//  MainViewController.swift
//  Delevery
//
//  Created by 노건호 on 2021/10/05.
//

import UIKit

protocol SendDataDelegate {
    func sendData(data: String)
}

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @available(iOS 13.0, *)
    @IBAction func menuButtonClicked(_ sender: UIButton) {
        guard let vc =  storyboard?.instantiateViewController(identifier: "NavigatedVarViewController") as? NavigatedVarViewController else
        { return }

        vc.text = sender.currentTitle!
        print(sender.currentTitle!)

        self.navigationController?.pushViewController(vc, animated: true)
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
