//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Rajeev Ram on 9/16/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    // UI, UX Objects
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var charCountLabel: UILabel!
    @IBOutlet weak var postButton: UIBarButtonItem!
    
    // Backend Variables
    weak var delegate: ComposeViewControllerDelegate?
    var characterLimit : Int = 141
    var user : User?
    var isReply : Bool = false
    var replyName : String?
    
    // Event Handlers
    @IBAction func onTapTweet(_ sender: Any) {
        let tweetText = tweetTextView.text!
        APIManager.shared.composeTweet(with: tweetText) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
            }
        }
        self.performSegue(withIdentifier: "ReturnSegue", sender: nil)
    }
    
    @IBAction func onTapCancel(_ sender: Any) {
        self.performSegue(withIdentifier: "ReturnSegue", sender: nil)
        APIManager.shared.updateTweetCount(user: User.current)
    }
    
    @IBAction func onTapElsewhere(_ sender: Any) {
        view.endEditing(true)
    }
    
    // Override
    override func viewDidLoad() {
        super.viewDidLoad()
        postButton.isEnabled = false
        tweetTextView.textColor = UIColor.lightGray
        tweetTextView.delegate = self as UITextViewDelegate
        updateUserInformation()
    }
    
    func updateUserInformation() {
        if let user = user {
            realNameLabel.text = user.name
            usernameLabel.text = "@\(user.screenName!)"
            if let propicURL = user.profilepic {
                profilePicture.af_setImage(withURL: propicURL)
            }
            
        }
        if (isReply), let replyName = self.replyName {
            tweetTextView.text = "@\(replyName) "
            tweetTextView.textColor = UIColor.black
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Delegate
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        let current = newText.count
        charCountLabel.text = "Character Count: \(current)"
        if (current == 0) {
            postButton.isEnabled = false
            return true;
        }
        postButton.isEnabled = true
        if (current < characterLimit) {
            charCountLabel.textColor = UIColor.lightGray
            return true
        } else {
            charCountLabel.textColor = UIColor.red
            if (current == characterLimit) {
                charCountLabel.text = "Character Count: 140"
            }
            return false
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.textColor == UIColor.lightGray) {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text.count == 0) {
            textView.text = "Write a post..."
            textView.textColor = UIColor.lightGray
            postButton.isEnabled = false
        }
    }

}

protocol ComposeViewControllerDelegate : class {
    func did(post : Tweet)
}
