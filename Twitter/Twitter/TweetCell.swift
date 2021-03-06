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
    var indexPath : IndexPath?
    
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
            self.updateFavoriteTweetCounts(tweet)
            self.updateFavoriteTweetIcons(tweet)
        }
    }
    
    func updateFavoriteTweetIcons(_ tweet: Tweet) {
        if (tweet.favorited! == true) {
            self.favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: .normal)
        }
        else {
            self.favoriteButton.setImage(UIImage(named: "favor-icon.png"), for: .normal)
        }
        if (tweet.retweeted == true) {
            self.retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: .normal)
        }
        else {
            self.retweetButton.setImage(UIImage(named: "retweet-icon.png"), for: .normal)
        }
    }
    
    func updateFavoriteTweetCounts(_ tweet: Tweet) {
        favoriteButton.setTitle("\(tweet.favoriteCount!)", for: .normal)
        retweetButton.setTitle("\(tweet.retweetCount)", for: .normal)
    }

    @IBAction func onTapFavorite(_ sender: Any) {
        if (tweet!.favorited == false) {
            APIManager.shared.favorite(self.tweet!) { (post, error) in
                if let  error = error {
                    print("Error Favoriting Tweet: \(error.localizedDescription)")
                } else {
                    self.parentView?.completeNetworkRequest()
                }
            }
        }
        else {
            APIManager.shared.unfavorite(self.tweet!) { (post, error) in
                if let  error = error {
                    print("Error Favoriting Tweet: \(error.localizedDescription)")
                } else {
                    self.parentView?.completeNetworkRequest()
                }
            }
        }
    }
    
    @IBAction func onTapRetweet(_ sender: Any) {
        if (tweet!.retweeted == false) {
            APIManager.shared.retweet(self.tweet!) { (post, error) in
                if let  error = error {
                    print("Error Favoriting Tweet: \(error.localizedDescription)")
                } else {
                    self.parentView?.completeNetworkRequest()
                }
            }
        }
        else {
            APIManager.shared.unretweet(self.tweet!) { (post, error) in
                if let  error = error {
                    print("Error Favoriting Tweet: \(error.localizedDescription)")
                } else {
                    self.parentView?.completeNetworkRequest()
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
