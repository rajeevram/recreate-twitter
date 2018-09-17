//
//  TweetViewController.swift
//  Twitter
//
//  Created by Rajeev Ram on 9/16/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // UI, UX Outlets
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var faveCount: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    
    // Backend Variables
    var user: User?
    var tweet : Tweet?
    
    // Override
    override func viewDidLoad() {
        super.viewDidLoad()
        self.user = self.tweet!.user
        updateUserInformation()
    }
    
    func updateUserInformation() {
        if let tweet = self.tweet, let user = self.user  {
            if let propicURL = user.profilepic {
                profilePicture.af_setImage(withURL: propicURL)
            }
            timeStampLabel.text = tweet.createdAtString
            realNameLabel.text = user.name
            usernameLabel.text = "@\(user.screenName!)"
            tweetTextLabel.text = tweet.text
            faveCount.text = "\(tweet.favoriteCount!)"
            tweetCount.text = "\(tweet.retweetCount)"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ReplySegue") {
            if let composeView = segue.destination as? ComposeViewController {
                composeView.isReply = true
                composeView.replyName = user?.screenName
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Event Handlers
    @IBAction func onTapReply(_ sender: Any) {
        self.performSegue(withIdentifier: "ReplySegue", sender: nil)
    }
    


}
