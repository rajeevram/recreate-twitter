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
    
    func updateAllContent(tweet : Tweet, user: User) {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
