//
//  ViewController.swift
//  InstaClone
//
//  Created by yekta on 13.02.2024.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    @IBOutlet weak var signInButtonUI: UIButton!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var createButtonUI: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButtonUI.layer.cornerRadius = 20
        signInButtonUI.layer.masksToBounds = true
        createButtonUI.layer.cornerRadius = 20
        createButtonUI.layer.masksToBounds = true
        
    }

    @IBAction func signInButtonClicked(_ sender: Any) {
        if (emailTxtFld.text != "" && passwordTxtFld.text != "") {
            Auth.auth().signIn(withEmail: emailTxtFld.text!, password: passwordTxtFld.text!) { authData, error in
                if (error != nil ){
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "")
                }
                else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: self)
                }
            }
        }
        else{
            makeAlert(title: "Error", message: "Email or password incorrect")
        }
    }
    
    @IBAction func createButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toCreateAccountVC", sender: self)
    }
    func makeAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

