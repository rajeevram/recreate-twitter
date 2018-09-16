//
//  TweetCell.swift
//  Twitter
//
//  Created by Rajeev Ram on 9/15/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {

    // UI, UX Variables
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet : Tweet?
    var user : User?
    var parentView : TimelineViewController?
    
    // Setup
    func updateAllContent() {
        if let tweet = self.tweet, let user = self.user {
            if let propicURL = user.profilepic {
                profilePicture.af_setImage(withURL: propicURL)
            }
            timeStampLabel.text = tweet.createdAtString
            fullNameLabel.text = user.name
            usernameLabel.text = "@\(user.screenName!)"
            tweetTextLabel.text = tweet.text
            retweetButton.setTitle("\(tweet.retweetCount)", for: .normal)
            favoriteButton.setTitle("\(tweet.favoriteCount!)", for: .normal)
        }
    }
    
    func updateFavoriteTweetCounts() {
        if let tweet = self.tweet {
            favoriteButton.setTitle("\(tweet.favoriteCount!)", for: .normal)
            retweetButton.setTitle("\(tweet.retweetCount)", for: .normal)
        }
    }

    @IBAction func onTapFavorite(_ sender: Any) {
        if (tweet!.favorited != true) {
            APIManager.shared.favorite(self.tweet!) { (tweet, error) in
                if let  error = error {
                    print("Error Favoriting Tweet: \(error.localizedDescription)")
                } else {
                    self.parentView?.completeNetworkRequest()
                    self.favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: .normal)
                }
            }
        }
        else {
            APIManager.shared.unfavorite(self.tweet!) { (tweet, error) in
                if let  error = error {
                    print("Error Favoriting Tweet: \(error.localizedDescription)")
                } else {
                    self.parentView?.completeNetworkRequest()
                    self.favoriteButton.setImage(UIImage(named: "favor-icon.png"), for: .normal)
                }
            }
        }
    }
    
    // Override
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
