//
//  UploadVC.swift
//  InstaClone
//
//  Created by yekta on 14.02.2024.
//

import UIKit
import FirebaseStorage
import Firebase
class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTxtFld: UITextField!
    @IBOutlet weak var uploadButtonUI: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadButtonUI.layer.cornerRadius = 20
        uploadButtonUI.layer.masksToBounds = true
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    @objc func selectImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    func makeAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        let uuid = UUID().uuidString
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if error != nil{
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "")
                }else{
                    imageReference.downloadURL{(url, error) in
                        if error == nil{
                            let imageUrl = url?.absoluteString
                            
                            
                            //DATABASE
                            let fireStoreDatabase = Firestore.firestore()
                            
                            var firestoreReference : DocumentReference? = nil
                            
                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email!, "postComment" : self.commentTxtFld.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0] as [String : Any]
                            
                            firestoreReference = fireStoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                if error != nil{
                                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                                }
                                else{
                                    self.imageView.image = UIImage(systemName:"photo.badge.plus")
                                    self.commentTxtFld.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                            
                            
                        }
                    }
                }
            }
        }
    }
    
    
}
