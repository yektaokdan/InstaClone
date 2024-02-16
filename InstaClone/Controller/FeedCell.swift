//
//  FeedCell.swift
//  InstaClone
//
//  Created by yekta on 15.02.2024.
//

import UIKit
import Firebase
class FeedCell: UITableViewCell {
    
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var likeLbl: UILabel!
    @IBOutlet weak var documentIDLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    @IBAction func likeButtonClicked(_ sender: Any) {
        let fireStoreDatabase = Firestore.firestore()
        if let likeCount = Int(likeLbl.text!){
            let likeStore = ["likes": likeCount + 1 ] as [String: Any]
            fireStoreDatabase.collection("Posts").document(documentIDLabel.text!).setData(likeStore, merge: true)
        }
        
        
    }
    
}
