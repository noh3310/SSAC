//
//  NavigatedVarViewController.swift
//  Delevery
//
//  Created by 노건호 on 2021/10/05.
//

import UIKit

class NavigatedVarViewController: UIViewController {
    
    @IBOutlet var navigationTitle: UINavigationItem!
    @IBOutlet var labelText: UILabel!
    var text = "text"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelText.text = text
        navigationItem.title = text
        print(text)
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
