//
//  FeedVC.swift
//  InstaClone
//
//  Created by yekta on 14.02.2024.
//

import UIKit
import Firebase
import SDWebImage
class FeedVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    

    @IBOutlet weak var tableView: UITableView!
    var userEmailArr = [String]()
    var userCommentArr = [String]()
    var likeArr = [Int]()
    var userImageArr = [String]()
    var documentIDArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromFiretStore()
    }
    func makeAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func getDataFromFiretStore(){
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "")
            }
            else{
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.userEmailArr.removeAll(keepingCapacity: false)
                    self.userCommentArr.removeAll(keepingCapacity: false)
                    self.userEmailArr.removeAll(keepingCapacity: false)
                    self.likeArr.removeAll(keepingCapacity: false)
                    self.documentIDArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents{
                        let documentID = document.documentID
                        self.documentIDArray.append(documentID)
                        
                        if let postedBy = document.get("postedBy") as? String{
                            self.userEmailArr.append(postedBy)
                        }
                        if let postComment = document.get("postComment") as? String{
                            self.userCommentArr.append(postComment)
                        }
                        if let likes = document.get("likes") as? Int{
                            self.likeArr.append(likes)
                        }
                        if let imageUrl = document.get("imageUrl") as? String{
                            self.userImageArr.append(imageUrl)
                        }
                    }
                    self.tableView.reloadData()
                }
                
            }
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell
        cell.userEmailLbl.text = userEmailArr[indexPath.row]
        cell.likeLbl.text = String(likeArr[indexPath.row])
        cell.commentLbl.text = userCommentArr[indexPath.row]
        cell.userImageView.sd_setImage(with: URL(string: userImageArr[indexPath.row]), placeholderImage:UIImage(named: "select.jpg"))
        cell.documentIDLabel.text = documentIDArray[indexPath.row]
        return cell
    }
}
