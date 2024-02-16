//
//  SettingsVC.swift
//  InstaClone
//
//  Created by yekta on 14.02.2024.
//

import UIKit
import Firebase
class SettingsVC: UIViewController {
    @IBOutlet weak var logoutButtonUI: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutButtonUI.layer.cornerRadius = 20
        logoutButtonUI.layer.masksToBounds = true
    }
    

    @IBAction func logoutButtonClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toMainVC", sender: self)
        } catch{
            print("Error")
        }
    }
    
}
