//
//  CreateAccountVC.swift
//  InstaClone
//
//  Created by yekta on 14.02.2024.
//

import UIKit
import Firebase
class CreateAccountVC: UIViewController {

    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var saveButtonUI: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButtonUI.layer.cornerRadius = 20
        saveButtonUI.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        if emailTxtFld.text != "" && passwordTxtFld.text != "" {
            Auth.auth().createUser(withEmail: emailTxtFld.text!, password: passwordTxtFld.text!) { authData, error in
                if (error != nil){
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Some error.")
                }
                else{
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        else{
           makeAlert(title: "Error", message: "Email or password incorrect.")
        }
        
    }
    func makeAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    

}
