//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Rajeev Ram on 9/16/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    // UI, UX Outlets
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var headerPhoto: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var statusCountLabel: UILabel!
    
    // Backend Variables
    var user : User?
    
    // Graphic Design Methods
    func updateAllContent() {
        if let user = self.user {
            if let propicURL = user.profilepic {
                profilePicture.af_setImage(withURL: propicURL)
            }
            if let bannerURL = user.bannerpic {
                headerPhoto.af_setImage(withURL: bannerURL)
            }
            realNameLabel.text = user.name
            usernameLabel.text = "@\(user.screenName!)"
            followerLabel.text = "\(user.followercount!)"
            followingLabel.text = "\(user.friendcount!)"
            statusCountLabel.text = "\(user.statusCount!)"

        }
    }
    
    func clipProfileImage() {
        profilePicture.layer.cornerRadius = profilePicture.layer.frame.height/2
        profilePicture.clipsToBounds = true
        profilePicture.layer.borderWidth = 1.5
        profilePicture.layer.borderColor = UIColor.black.cgColor
        
    }
    
    func organizeProperColors() {
        backgroundView.backgroundColor = UIColor(red: 200/255, green: 249/255, blue: 255/255, alpha: 1)
        labelView.layer.borderWidth = 0.5
        labelView.layer.borderColor = UIColor.black.cgColor
    }
    
    
    @IBAction func onTapCompose(_ sender: Any) {
        self.performSegue(withIdentifier: "ComposeProfile", sender: nil)
    }
    
    // Override
    override func viewDidLoad() {
        organizeProperColors()
        updateAllContent()
        clipProfileImage()
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
